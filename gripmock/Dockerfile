# BASE_TAG *may* include VERSION, docker docs use TAG for the image being built
# https://docs.docker.com/engine/reference/commandline/image_tag/
ARG BASE_TAG=latest

FROM bavix/gripmock:2.4.0

# NOTE: the protoc stuff is copied from the builder image repo.

# protoc command
ENV PROTOC_VERSION=24.3
RUN PROTOC_ARCH=$(uname -m); \
  if test "$PROTOC_ARCH" = "aarch64"; then PROTOC_ARCH=aarch_64; fi; \
  wget https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-${PROTOC_ARCH}.zip \
  && unzip -q -o protoc-${PROTOC_VERSION}-linux-${PROTOC_ARCH}.zip -d /usr/local bin/protoc \
  && chmod +x /usr/local/bin/protoc \
  && unzip -q -o protoc-${PROTOC_VERSION}-linux-${PROTOC_ARCH}.zip -d /usr/local include/* \
  && chmod -R +rx /usr/local/include \
  && rm -rf protoc-${PROTOC_VERSION}-linux-${PROTOC_ARCH}.zip

# Download common google api proto files.
ENV GOOGLE_COMMON_PROTOS_VERSION=1.50.0
RUN wget https://github.com/googleapis/api-common-protos/archive/refs/tags/${GOOGLE_COMMON_PROTOS_VERSION}.tar.gz \
  && tar -C /usr/local -xvzf ${GOOGLE_COMMON_PROTOS_VERSION}.tar.gz \
  && rm -rf /usr/local/usr/local/api-common-protos-master \
  && mv /usr/local/api-common-protos-${GOOGLE_COMMON_PROTOS_VERSION} /usr/local/api-common-protos-master \
  && rm -f ${GOOGLE_COMMON_PROTOS_VERSION}.tar.gz

# https://github.com/golang/protobuf/releases
# https://github.com/grpc-ecosystem/grpc-gateway/releases
# https://github.com/protocolbuffers/protobuf/releases
#
# TODO: it is not recommended to install pinned versions of grpc_gateway,
#       protoc-gen-go and protoc-gen-grpc-gateway in a Dockerfile. Less
#       prone to failure is to rely on the tools/tools.go file and control
#       versions in go.mod. (Single source of truth)
#       (From conversation with jbrandhorst on slack grpc-gateway channel)
#       see ticket #756
#       Howver - for now - we must ensure that versions in this Dockerfile
#       corerspond to versions in src/go.mod in the avid repo
# ensure that these values correspond to those in src/go.mod
# Hybrid tools - installs tools plus importable packages
ENV GRPC_GATEWAY_VERSION=2.18.0
RUN go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@v${GRPC_GATEWAY_VERSION} \
  && go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@v${GRPC_GATEWAY_VERSION}

ENV PROTOC_GEN_GO_GRPC_VERSION=1.3.0
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v${PROTOC_GEN_GO_GRPC_VERSION}

# Additional proto utilities
ENV PROTOC_GEN_VALIDATE_VERSION=v1.0.2
ENV PROTOC_GEN_DOC_VERSION=v1.5.1
RUN go install github.com/envoyproxy/protoc-gen-validate@${PROTOC_GEN_VALIDATE_VERSION} \
  && go install github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc@${PROTOC_GEN_DOC_VERSION}

# add go.mod to allow datrails api module
COPY go-ext.mod /go/src/github.com/bavix/gripmock/go-ext.mod
RUN cat /go/src/github.com/bavix/gripmock/go-ext.mod >> /go/src/github.com/bavix/gripmock/go.mod

# ensure we download the datatrails common api generated code
RUN go mod download github.com/datatrails/go-datatrails-common-api-gen
RUN go get github.com/datatrails/go-datatrails-common-api-gen/assets/v2/assets@v0.3.3

# due to us passing in the proto and also using the api gen as a dependency
#  we have a namespace conflict, however they are both the same proto, so just turn
#  the error into a warning.
ENV GOLANG_PROTOBUF_REGISTRATION_CONFLICT=warn

ENTRYPOINT ["gripmock"]