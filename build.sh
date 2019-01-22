#!/usr/bin/env bash
set -e

build() {
    docker build . \
        -t codeblick/shopware-demo:${1} \
        --build-arg COB_SW_VERSION=${1} \
        --build-arg COB_DEMO_DATA_VERSION=${2} \
        -q
}

build 5.3.0 5_2_0
build 5.3.1 5_2_0
build 5.3.2 5_2_0
build 5.3.3 5_2_0
build 5.3.4 5_2_0
build 5.3.5 5_2_0
build 5.3.6 5_2_0
build 5.3.7 5_2_0

build 5.4.0 5_4_0
build 5.4.1 5_4_0
build 5.4.2 5_4_0
build 5.4.3 5_4_0
build 5.4.4 5_4_0
build 5.4.5 5_4_0
build 5.4.6 5_4_0

build 5.5.0 5_4_0
build 5.5.1 5_4_0
build 5.5.2 5_4_0
build 5.5.3 5_4_0
build 5.5.4 5_4_0
build 5.5.5 5_4_0
build 5.5.6 5_4_0
