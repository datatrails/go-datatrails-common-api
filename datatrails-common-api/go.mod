module github.com/datatrails/go-datatrails-common-api-gen

// Note: the go code is hosted in github.com/datatrails/go-datatrails-common-api-gen
// hence the module name

go 1.21

// This allows this module to operate as tho it were the generated module. This
// allows us to manage the proto tool dependencies via this go.mod. This go.mod
// is also used as the go.mod for the generated package.
replace github.com/datatrails/go-datatrails-common-api-gen => ./

require (
	github.com/datatrails/go-datatrails-common v0.10.2
	github.com/envoyproxy/protoc-gen-validate v1.0.2
	github.com/google/uuid v1.4.0
	github.com/grpc-ecosystem/grpc-gateway/v2 v2.18.1
	github.com/lyft/protoc-gen-star/v2 v2.0.3
	github.com/pseudomuto/protoc-gen-doc v1.5.1
	github.com/spf13/afero v1.3.3
	github.com/stretchr/testify v1.8.4
	go.mongodb.org/mongo-driver v1.12.1
	google.golang.org/genproto/googleapis/api v0.0.0-20231127180814-3a041ad873d4
	google.golang.org/grpc v1.59.0
	google.golang.org/grpc/cmd/protoc-gen-go-grpc v1.3.0
	google.golang.org/protobuf v1.31.0
	gopkg.in/yaml.v3 v3.0.1
)

require (
	github.com/KimMachineGun/automemlimit v0.2.6 // indirect
	github.com/Masterminds/goutils v1.1.1 // indirect
	github.com/Masterminds/semver v1.5.0 // indirect
	github.com/Masterminds/sprig v2.22.0+incompatible // indirect
	github.com/cilium/ebpf v0.9.1 // indirect
	github.com/containerd/cgroups/v3 v3.0.1 // indirect
	github.com/coreos/go-systemd/v22 v22.3.2 // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/docker/go-units v0.4.0 // indirect
	github.com/godbus/dbus/v5 v5.0.4 // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/protobuf v1.5.3 // indirect
	github.com/huandu/xstrings v1.4.0 // indirect
	github.com/iancoleman/strcase v0.2.0 // indirect
	github.com/imdario/mergo v0.3.16 // indirect
	github.com/mitchellh/copystructure v1.2.0 // indirect
	github.com/mitchellh/reflectwalk v1.0.2 // indirect
	github.com/mwitkow/go-proto-validators v0.3.2 // indirect
	github.com/opencontainers/runtime-spec v1.0.2 // indirect
	github.com/opentracing/opentracing-go v1.2.0 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	github.com/pseudomuto/protokit v0.2.1 // indirect
	github.com/sirupsen/logrus v1.8.1 // indirect
	go.uber.org/automaxprocs v1.5.3 // indirect
	go.uber.org/multierr v1.10.0 // indirect
	go.uber.org/zap v1.25.0 // indirect
	golang.org/x/crypto v0.16.0 // indirect
	golang.org/x/mod v0.11.0 // indirect
	golang.org/x/net v0.17.0 // indirect
	golang.org/x/sys v0.15.0 // indirect
	golang.org/x/text v0.14.0 // indirect
	golang.org/x/tools v0.10.0 // indirect
	google.golang.org/genproto v0.0.0-20231127180814-3a041ad873d4 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20231120223509-83a465c0220f // indirect
)
