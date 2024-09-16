ARTIFACT_ID=silly-dogu
VERSION=1.11.1-1

MAKEFILES_VERSION=9.1.0

GO_ENV_VARS=CGO_ENABLED=0
GOTAG=1.23.1
GO_ENVIRONMENT=GO111MODULE=on

include build/make/variables.mk

PACKAGES_FOR_INTEGRATION_TEST=$(shell ${GO_CALL} list ./... | grep "api")

include build/make/self-update.mk
include build/make/dependencies-gomod.mk
include build/make/build.mk
include build/make/test-common.mk
include build/make/test-integration.mk
include build/make/test-unit.mk
include build/make/static-analysis.mk
include build/make/clean.mk