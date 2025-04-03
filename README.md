# go-datatrails-common-api

Common public api definitions for the DataTrails platform

## Finding and including proto files for dependencies

go.mod is the source of truth for all proto providing dependencies. That file alone specifies both the upstream version we are using *and* is used, via go get -tool, to make the .proto files available locally

This corresponds to the practice recommended by grpc-gateway and elsewhere.

1. Execute the `go get -tool` command to add the package to the go.mod file. This is a once-off command that simply
   sets up go.mod to manages all tools.
2. If necessary, add a var for the new path in any-api **and** then add a reference to that var in the PROTO_INC var.
3. Executing 'go install tool' is then sufficient to install required tools and the only command required in workflows.

## Using the go tool commands

These commands are NOT executed as part of the dev workflow. 

Add tools to the go.mod file:

```
    go get -tool github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@v2.23.0
    go get -tool github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@v2.23.0
    go get -tool google.golang.org/protobuf/cmd/protoc-gen-go@v1.36.5
    go get -tool google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.5.1
    go get -tool github.com/envoyproxy/protoc-gen-validate@v1.2.1
```

Inspect the go.mod file and show the 'tool' section:

```
tool (
	github.com/envoyproxy/protoc-gen-validate
	github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway
	github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
	google.golang.org/grpc/cmd/protoc-gen-go-grpc
	google.golang.org/protobuf/cmd/protoc-gen-go
)
```

Show installed tools

```
    go tool
```

## bootstrap proto files

The proto's for protoc itself, the googleapis, and the grpc_health proxy are needed by almost everything and are also don't apear to be compatible with the tools/go.mod approach

For this reason we curl the proto's and make them available in our aggregate proto-includes archive

## Workflow for updating common apis

### Ensure tools are setup on your host

This repo uses the go-task tool and also the go toolchain. The dev workflow is described below.


#### For this repo

If you are iterating it is a lot more efficient to use the sub tasks, because they all run on your host.

`task` `apis:bootstrap` -> `task:apis:generate` -> `task:apis:test` -> `task:apis:export`

The source of truth for the host build is .github/workflows/ci.yml as that is
how the CI pipeline works. It does not use our builder image.

| Command                        | When                            |
| ---------------------          | ------------------------------: |
| `task apis:bootstrap`          | once after clone or rebase      |
| `task apis:clean:generated`    | once after clone or rebase      |
| `task apis:generate`           | every time the .proto changes   |
| `task apis:test`               | every time the .proto changes   |
| `task apis:export`             | every time the .proto changes   |

If you want to iterate on *just* the helper go code and there tests, do one round of

`apis:bootstrap` -> `apis:clean:generated`

Then just iterate using `task apis:generate` and `task apis:test`

##### Build one api against locally cloned go-datatrails-common-api

The protos can be included exactly as they are found from a clone of go-datatrails-common-api. *Without* needing to generate, build or export. Eg,

    task apis:assetsv2-api \
        DATATRAILS_COMMON_API="../../go-datatrails-common-api"

It is necessary however to run `task apis:bootstrap` after cloning go-datatrails-common-api.
