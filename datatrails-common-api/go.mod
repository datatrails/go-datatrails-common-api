module github.com/datatrails/go-datatrails-common-api-gen

// Note: the go code is hosted in github.com/datatrails/go-datatrails-common-api-gen
// hence the module name

go 1.23.0

// This allows this module to operate as tho it were the generated module. This
// allows us to manage the proto tool dependencies via this go.mod. This go.mod
// is also used as the go.mod for the generated package.
// replace github.com/datatrails/go-datatrails-common-api-gen => ./

require (
	github.com/datatrails/go-datatrails-common v0.28.0
	github.com/envoyproxy/protoc-gen-validate v1.2.1
	github.com/google/uuid v1.6.0
	github.com/grpc-ecosystem/grpc-gateway/v2 v2.23.0
	github.com/lyft/protoc-gen-star/v2 v2.0.4-0.20230330145011-496ad1ac90a4
	github.com/stretchr/testify v1.10.0
	go.mongodb.org/mongo-driver v1.17.3
	google.golang.org/genproto/googleapis/api v0.0.0-20250106144421-5f5ef82da422
	google.golang.org/grpc v1.71.1
	google.golang.org/grpc/cmd/protoc-gen-go-grpc v1.3.0
	google.golang.org/protobuf v1.36.6
	gopkg.in/yaml.v3 v3.0.1
)

require (
	github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc // indirect
	github.com/iancoleman/strcase v0.3.0 // indirect
	github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2 // indirect
	github.com/rogpeppe/go-internal v1.6.1 // indirect
	github.com/spf13/afero v1.10.0 // indirect
	go.uber.org/multierr v1.11.0 // indirect
	go.uber.org/zap v1.27.0 // indirect
	golang.org/x/mod v0.17.0 // indirect
	golang.org/x/net v0.34.0 // indirect
	golang.org/x/sys v0.30.0 // indirect
	golang.org/x/text v0.22.0 // indirect
	golang.org/x/tools v0.21.1-0.20240508182429-e35e4ccd0d2d // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20250115164207-1a7da9e5054f // indirect
)
