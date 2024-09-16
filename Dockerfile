FROM golang:1.23.1-alpine3.20 AS builder

RUN apk add --update curl git make

ENV WORKDIR=/go/src/github.com/ppxl/silly-dogu

WORKDIR ${WORKDIR}

COPY go.mod go.sum ${WORKDIR}/
COPY . ${WORKDIR}

RUN make compile-ci

FROM registry.cloudogu.com/official/base:3.20.3-1

LABEL maintainer="hello@cloudogu.com" \
    NAME="official/silly-dogu" \
    VERSION="0.1.0-1"
ENV USER=silly-goose \
    STARTUP_DIR=/resources \
    SERVICE_TAGS=webapp \
    # pass to /silly-dogu/ to get
    SERVICE_ADDITIONAL_SERVICES='[{"name": "schmu", "port": 8080, "location": "schmilly", "pass": "/silly-dogu/"}]'

RUN set -eux -o pipefail \
    && addgroup -S "${USER}" -g 1000 \
    && adduser -S -h "/app" -G "${USER}" -u 1000 -s /bin/bash "${USER}"

USER 1000:1000

COPY --chown=1000:1000 resources/ ${STARTUP_DIR}/
COPY --chown=1000:1000 --from=builder /go/src/github.com/ppxl/silly-dogu/target/silly-dogu ${STARTUP_DIR}/silly-dogu

EXPOSE 8080

HEALTHCHECK --interval=5s CMD doguctl healthy backup || exit 1

CMD /resources/startup.sh
