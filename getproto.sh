#!/usr/bin/sh
cd datatrails-common-api/
echo $(GOCACHE=/tmp/datatrails/go-datatrails-common-api/api go list -f {{.Dir}} $1)