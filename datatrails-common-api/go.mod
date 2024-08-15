module github.com/datatrails/go-datatrails-common-api-gen

// Note: the go code is hosted in github.com/datatrails/go-datatrails-common-api-gen
// hence the module name

go 1.22

// This allows this module to operate as tho it were the generated module. This
// allows us to manage the proto tool dependencies via this go.mod. This go.mod
// is also used as the go.mod for the generated package.
// replace github.com/datatrails/go-datatrails-common-api-gen => ./

require (
	github.com/datatrails/go-datatrails-common v0.18.0
	github.com/envoyproxy/protoc-gen-validate v1.0.4
	github.com/google/uuid v1.6.0
	github.com/grpc-ecosystem/grpc-gateway/v2 v2.20.0
	github.com/lyft/protoc-gen-star/v2 v2.0.3
	github.com/pseudomuto/protoc-gen-doc v1.5.1
	github.com/spf13/afero v1.10.0
	github.com/stretchr/testify v1.9.0
	go.mongodb.org/mongo-driver v1.12.1
	google.golang.org/genproto/googleapis/api v0.0.0-20240701130421-f6361c86f094
	google.golang.org/grpc v1.65.0
	google.golang.org/grpc/cmd/protoc-gen-go-grpc v1.3.0
	google.golang.org/protobuf v1.34.2
	gopkg.in/yaml.v3 v3.0.1
)

require (
	github.com/Masterminds/goutils v1.1.1 // indirect
	github.com/Masterminds/semver v1.5.0 // indirect
	github.com/Masterminds/sprig v2.22.0+incompatible // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/protobuf v1.5.4 // indirect
	github.com/huandu/xstrings v1.4.0 // indirect
	github.com/iancoleman/strcase v0.3.0 // indirect
	github.com/imdario/mergo v0.3.16 // indirect
	github.com/mitchellh/copystructure v1.2.0 // indirect
	github.com/mitchellh/reflectwalk v1.0.2 // indirect
	github.com/mwitkow/go-proto-validators v0.3.2 // indirect
	github.com/opentracing/opentracing-go v1.2.0 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	github.com/pseudomuto/protokit v0.2.1 // indirect
	github.com/rogpeppe/go-internal v1.6.1 // indirect
	go.uber.org/multierr v1.10.0 // indirect
	go.uber.org/zap v1.25.0 // indirect
	golang.org/x/crypto v0.25.0 // indirect
	golang.org/x/mod v0.17.0 // indirect
	golang.org/x/net v0.27.0 // indirect
	golang.org/x/sys v0.22.0 // indirect
	golang.org/x/text v0.16.0 // indirect
	golang.org/x/tools v0.21.1-0.20240508182429-e35e4ccd0d2d // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20240624140628-dc46fd24d27d // indirect
)
