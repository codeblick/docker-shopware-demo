#!/usr/bin/env bash
set -e

build() {
    docker build . \
        -t codeblick/shopware-demo:${1} \
        --build-arg COB_SW_VERSION=${1} \
        -q
}

build 5.3.0
build 5.3.1
build 5.3.2
build 5.3.3
build 5.3.4
build 5.3.5
build 5.3.6
build 5.3.7

build 5.4.0
build 5.4.1
build 5.4.2
build 5.4.3
build 5.4.4
build 5.4.5
build 5.4.6

build 5.5.0
build 5.5.1
build 5.5.2
build 5.5.3
build 5.5.4
build 5.5.5
