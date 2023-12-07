//go:build tools
// +build tools

package tools

import (
	// needed in order to have the envoyproxy package reliably available when
	// generating code.
	_ "github.com/envoyproxy/protoc-gen-validate/templates/java"
	_ "github.com/envoyproxy/protoc-gen-validate/validate"
	_ "github.com/lyft/protoc-gen-star/v2/lang/go"

	// _ "github.com/grpc-ecosystem/grpc-gateway/v2/runtime"

	_ "github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway"
	_ "github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2"
	_ "github.com/pseudomuto/protoc-gen-doc"
	_ "github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc"
	_ "github.com/spf13/afero"
	_ "google.golang.org/grpc/cmd/protoc-gen-go-grpc"
	_ "google.golang.org/protobuf/cmd/protoc-gen-go"
	_ "gopkg.in/yaml.v3"
)
