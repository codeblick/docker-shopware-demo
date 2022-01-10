#!/usr/bin/env bash
set -e

build() {
    docker build . \
        -t codeblick/shopware-demo:${1} \
        --build-arg COB_SW_VERSION=${1} \
        --build-arg COB_DEMO_DATA_VERSION=${2} \
        -q
}

build 5.7.3 5_5_0
build 5.7.4 5_5_0
build 5.7.5 5_5_0
build 5.7.6 5_5_0
build 5.7.7 5_5_0
