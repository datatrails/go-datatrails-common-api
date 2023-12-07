# go-datatrails-common-api

Common public api definitions for the DataTrails platform

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

`task` `apis:bootstrap` -> `task:apis:generate` -> `task:apis:export`

The source of truth for the host build is .github/workflows/ci.yml as that is
how the CI pipeline works. It does not use our builder image.

| Command                        | When                            |
| ---------------------          | ------------------------------: |
| `task apis:bootstrap`          | once after clone or rebase      |
| `task apis:clean:generated`    | once after clone or rebase      |
| `task apis:generate`           | every time the .proto changes   |
| `task apis:export`             | every time the .proto changes   |

If you want to iterate on *just* the helper go code and there tests, do one round of

`apis:bootstrap` -> `apis:clean:generated`

Then just iterate using `apis:build`


#### For avid

* task avid:xxx

##### Build one api against locally cloned go-datatrails-common-api

The protos can be included exactly as they are found from a clone of go-datatrails-common-api. *Without* needing to generate, build or export. Eg,

    task apis:assetsv2-api \
        DATATRAILS_COMMON_API_INC="-I $(pwd)/../../go-datatrails-common-api/proto-include -I $(pwd)/../../go-datatrails-common-api"

It is necessary however to run `task apis:bootsrap` after cloning go-datatrails-common
        
#### For forestrie

* task:xxx
