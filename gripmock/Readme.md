## Gripmock is a mock for proto

Got as far as including the proto in a command like this

## Build the docker image

```
docker build . -t gripmock
```

## Run gRPC mock server

```
docker run -p 4770:4770 -p 4771:4771 -v ~/workspace/go-datatrails-common-api:/protobuf -v ~/workspace/go-datatrails-common-api:/proto gripmock --imports=/protobuf,/usr/local/api-common-protos-master,/usr/local/include,/go/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v1.0.2,/go/pkg/mod/github.com/grpc-ecosystem/grpc-gateway/v2@v2.18.0 /proto/datatrails-common-api/assets/v2/assets/service.proto
```

## Now the gRPC server is up and running, we can add expectations of the assets grpc service:

```
curl -X POST -d '{"service":"Assets", "method":"GetAsset","input":{"equals":{"uuid":"foo"}},"output":{"data":{"identity":"foo", "public":true}}}' localhost:4771/api/stubs
```

response:

```
Success add stub
```

## Finally we can use grpcurl or similar to check that the service works:

```
grpcurl -plaintext -d '{"uuid":"foo"}' localhost:4770 archivist.v2.Assets/GetAsset
```

response:

```
{
  "identity": "foo",
  "public": true
}
```