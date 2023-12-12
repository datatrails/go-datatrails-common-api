module github.com/tokopedia/gripmock

go 1.15

replace (
	// These pseudoversions are for: ConsenSys/quorum@v22.4.4
	github.com/coreos/etcd => github.com/Consensys/etcd v3.3.13-quorum197+incompatible

	// github.com/datatrails/go-datatrails-common-api => ../../go-datatrails-common-api/api
	github.com/ethereum/go-ethereum => github.com/ConsenSys/quorum v0.0.0-20221208112643-d318a5aa973a
	// github.com/ethereum/go-ethereum/crypto/secp256k1 => github.com/ConsenSys/goquorum-crypto-secp256k1 v0.0.2
	github.com/ethereum/go-ethereum/crypto/secp256k1 => github.com/ConsenSys/goquorum-crypto-secp256k1 v0.0.2

)

require (
	github.com/datatrails/go-datatrails-common-api-gen v0.3.3 // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/go-chi/chi v4.1.2+incompatible
	github.com/golang/protobuf v1.5.3
	github.com/lithammer/fuzzysearch v1.1.1
	github.com/stretchr/testify v1.8.4
	github.com/tokopedia/gripmock/protogen v0.0.0 // indirect
	github.com/tokopedia/gripmock/protogen/example v0.0.0 // indirect
	google.golang.org/genproto v0.0.0-20231127180814-3a041ad873d4
	google.golang.org/grpc v1.59.0
	google.golang.org/protobuf v1.31.0
)

// this is for generated server to be able to run
replace github.com/tokopedia/gripmock/protogen/example v0.0.0 => ./protogen/example

// this is for example client to be able to run
replace github.com/tokopedia/gripmock/protogen v0.0.0 => ./protogen