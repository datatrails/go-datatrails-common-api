package simplehash

// Public go lang implementation of the simplehash RKVST event encoding scheme
// This lives with the common api because it's job in life is to ensure stable
// hashing of event data received by an api consumer

import (
	"crypto/sha256"
	"encoding/json"
	"fmt"
	"hash"

	v2assets "github.com/rkvst/go-rkvstcommon-api-gen/assets/v2/assets"
	"github.com/rkvst/go-rkvstcommon-api-gen/marshalers/simpleoneof"
	"github.com/zeebo/bencode"
)

type HasherV2 struct {
	hasher    hash.Hash
	marshaler *simpleoneof.Marshaler
}

func NewHasherV2() HasherV2 {
	h := HasherV2{
		hasher:    sha256.New(),
		marshaler: NewEventMarshaler(),
	}
	return h
}

type HashOptions struct {
	accumulateHash         bool
	publicFromPermissioned bool
	asConfirmed            bool
}

type HashOption func(*HashOptions)

func WithAccumulate() HashOption {
	return func(o *HashOptions) {
		o.accumulateHash = true
	}
}

func WithPublicFromPermissioned() HashOption {
	return func(o *HashOptions) {
		o.publicFromPermissioned = true
	}
}

func WithAsConfirmed() HashOption {
	return func(o *HashOptions) {
		o.asConfirmed = true
	}
}

// Reset resets the hasher state
// This is only useful in combination with WithAccumulate
func (h *HasherV2) Reset() { h.hasher.Reset() }

// HashEvent hashes a single event according to the public event format
// available to api consumers.
//
// Options:
//   - WithAccumulate callers wishing to implement batched hashing of multiple
//     events in series should set this. They should call Reset() at their batch
//     boundaries.
//   - WithPubliicFromPermissioned should be set if the event is the
//     permissioned (owner) counter part of a public attestation.
//   - WithAsConfirmed should be set if the caller is implementing CONFIRMATION
//     as part of an evidence subsystem implementation. The expectation is that
//     the caller has a PENDING record to hand, and is in the process of
//     creating the CONFIRMED record. It is the CONFIRMED record that needs to
//     be publicly verifiable.
func (h *HasherV2) HashEvent(event *v2assets.EventResponse, opts ...HashOption) error {
	o := HashOptions{}
	for _, opt := range opts {
		opt(&o)
	}

	var err error

	// By default, one hash at at time with a reset.
	if !o.accumulateHash {
		h.hasher.Reset()
	}

	if o.publicFromPermissioned {
		PublicFromPermissionedEvent(event)
	}

	// If the caller is responsible for evidence confirmation they will have a
	// pending event in their hand. But ultimately it is the confirmed record
	// that is evidential and subject to public verification.
	if o.asConfirmed {
		event.ConfirmationStatus = v2assets.ConfirmationStatus_CONFIRMED
	}
	err = EventSimpleHashV2(h.hasher, h.marshaler, event)
	if err != nil {
		return err
	}
	return nil
}

func (h *HasherV2) Sum() []byte {
	return h.hasher.Sum(nil)
}

// EventV2 is a struct that contains ONLY the event fields we want to hash for schema v2
type EventV2 struct {
	Identity           string         `json:"identity"`
	AssetIdentity      string         `json:"asset_identity"`
	EventAttributes    map[string]any `json:"event_attributes"`
	AssetAttributes    map[string]any `json:"asset_attributes"`
	Operation          string         `json:"operation"`
	Behaviour          string         `json:"behaviour"`
	TimestampDeclared  string         `json:"timestamp_declared"`
	TimestampAccepted  string         `json:"timestamp_accepted"`
	TimestampCommitted string         `json:"timestamp_committed"`
	PrincipalAccepted  map[string]any `json:"principal_accepted"`
	PrincipalDeclared  map[string]any `json:"principal_declared"`
	ConfirmationStatus string         `json:"confirmation_status"`
	From               string         `json:"from"`
	TenantIdentity     string         `json:"tenant_identity"`
}

// NewEventMarshaler creates a flat marshaler to transform events to api format.
//
// otherwise attributes look like this: {"foo":{"str_val": "bar"}} instead of {"foo": "bar"}
// this mimics the public list events api response, so minimises changes to the
// public api response, to reproduce the anchor
func NewEventMarshaler() *simpleoneof.Marshaler {
	return v2assets.NewFlatMarshalerForEvents()
}

// TransformOne transforms a single event in grpc proto format (message bus
// compatible) to the canonical, publicly verifiable, api format.
func TransformOne(marshaler *simpleoneof.Marshaler, event *v2assets.EventResponse) (EventV2, error) {
	eventJson, err := marshaler.Marshal(event)
	if err != nil {
		return EventV2{}, err
	}
	eventShashV2 := EventV2{}
	err = json.Unmarshal(eventJson, &eventShashV2)
	if err != nil {
		return EventV2{}, err
	}
	return eventShashV2, nil
}

// PublicFromPermissionedEvent translates the permissioned event and asset identities to
// their public counter parts.
func PublicFromPermissionedEvent(event *v2assets.EventResponse) {
	event.Identity = v2assets.PublicIdentityFromPermissioned(event.Identity)
	event.AssetIdentity = v2assets.PublicIdentityFromPermissioned(event.AssetIdentity)
}

// EventSimpleHashV2 hashes a single event according to the public event format
// available to api consumers.
//
//   - If the event is the permissioned (owner) counter part of a public
//     attestation, you must call PublicFromPermissionedEvent first.
//   - No special treatment is given to confirmation status (PENDING vs
//     CONFIRMED). Because the rules for forestrie and PENDING events are *NOT
//     THE SAME* as those for proof_mechanism simplehash.
func EventSimpleHashV2(hasher hash.Hash, marshaler *simpleoneof.Marshaler, event *v2assets.EventResponse) error {

	var err error

	// Note that we _don't_ take any notice of confirmation status.

	eventShashV2, err := TransformOne(marshaler, event)
	if err != nil {
		return err
	}

	// XXX: TODO I don't think the following step is necessary (we should get snake case due to the struct tags)
	//    we get the correct fields by the definition of our structure, but we need to marshal and unmarshal our struct
	//    into a generic []any, in order to get the correct field names, otherwise they would be camelcase
	eventJson, err := json.Marshal(eventShashV2)
	if err != nil {
		return fmt.Errorf("EventSimpleHashV2: failed to marshal event : %v", err)
	}

	var jsonAny any

	if err = json.Unmarshal(eventJson, &jsonAny); err != nil {
		return fmt.Errorf("EventSimpleHashV2: failed to unmarshal events: %v", err)
	}

	bencodeEvent, err := bencode.EncodeBytes(jsonAny)
	if err != nil {
		return fmt.Errorf("EventSimpleHashV2: failed to bencode events: %v", err)
	}

	hasher.Write(bencodeEvent)
	return nil
}
