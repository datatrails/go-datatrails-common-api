module github.com/datatrails/go-datatrails-common-api-gen

// Note: the go code is hosted in github.com/datatrails/go-datatrails-common-api-gen
// hence the module name

go 1.24

// This allows this module to operate as tho it were the generated module. This
// allows us to manage the proto tool dependencies via this go.mod. This go.mod
// is also used as the go.mod for the generated package.
// replace github.com/datatrails/go-datatrails-common-api-gen => ./

require (
	github.com/datatrails/go-datatrails-common v0.30.0
	github.com/envoyproxy/protoc-gen-validate v1.2.1
	github.com/google/uuid v1.6.0
	github.com/grpc-ecosystem/grpc-gateway/v2 v2.26.3
	github.com/stretchr/testify v1.10.0
	go.mongodb.org/mongo-driver v1.17.3
	google.golang.org/genproto/googleapis/api v0.0.0-20250303144028-a0af3efb3deb
	google.golang.org/grpc v1.72.0
	google.golang.org/protobuf v1.36.6
)

require (
	github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc // indirect
	github.com/iancoleman/strcase v0.3.0 // indirect
	github.com/lyft/protoc-gen-star/v2 v2.0.4 // indirect
	github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2 // indirect
	github.com/spf13/afero v1.14.0 // indirect
	go.uber.org/multierr v1.11.0 // indirect
	go.uber.org/zap v1.27.0 // indirect
	golang.org/x/mod v0.18.0 // indirect
	golang.org/x/net v0.39.0 // indirect
	golang.org/x/sys v0.32.0 // indirect
	golang.org/x/text v0.24.0 // indirect
	golang.org/x/tools v0.22.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20250428153025-10db94c68c34 // indirect
	google.golang.org/grpc/cmd/protoc-gen-go-grpc v1.5.1 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
)

tool (
	github.com/envoyproxy/protoc-gen-validate
	github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway
	github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
	google.golang.org/grpc/cmd/protoc-gen-go-grpc
	google.golang.org/protobuf/cmd/protoc-gen-go
)
