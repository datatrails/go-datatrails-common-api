# go-datatrails-common-api

Common public api definitions for the DataTrails platform

## Finding and including proto files for depdendecnies

tools/go.mod is the source of truth for all proto providing dependencies. That file alone specifies both the upstream version we are using *and* is used, via go install, to make the .proto files available locally

This corresponds to the practice recommended by grpc-gateway and elsewhere

1. *** ALWAYS *** Use tools/go.mod to specify the dependency version.
2. Add the package to the `go install` command in the apis:preflight task
3. If necessary, add a var for the new path in any-api **and** then add a reference to that var in the PROTO_INC var.

Following this practice removes the need for dual maintenance of dependency versions in the builder image. It also produces a build cycle that is significantly faster.

Cross repository builds in docker while using go.work to refer to locally modified sources don't work. And this setup is essential for an efficient workflow.

## bootstrap proto files

The proto's for protoc itself, the googleapis, and the grpc_health proxy are needed by almost everything and are also don't apear to be compatible with the tools/go.mod approach

For this reason we curl the proto's and make them available in our aggregate proto-includes archive

## Workflow for updating common apis

### Ensure the go tool chain is setup on your host

It is inordinately cumbersome to set this all up for docker. It can't be
achieved without imposing significant inneficiencies in the workflow. For any
engineer working on the api's it is reasonable to expect they can install the
correct version of go for their host, and likely already have.

### Use an avid/src/go.work

First point avid at a clone of this repo so that it's imports will resolve
directly against the sources in `./api`

### Familiarize with the workflow sub tasks

The general use entry points all use Docker and do not support efficiently and
iteratively developing avid and other dependents against a local clone of this
repo.

#### For this repo

You can do everything in the builder image using `task all`. This uses the
blessed builder image and requires no host setup other than docker.

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

#### For avid

See the README.md in avid/src/api/README.md

##### Build one api against locally cloned go-datatrails-common-api

The protos can be included exactly as they are found from a clone of go-datatrails-common-api. *Without* needing to generate, build or export. Eg,

    task apis:assetsv2-api \
        DATATRAILS_COMMON_API="../../go-datatrails-common-api"

It is necessary however to run `task apis:bootsrap` after cloning go-datatrails-common