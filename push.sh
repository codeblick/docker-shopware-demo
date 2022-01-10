#!/usr/bin/env bash
set -e

push() {
    docker push codeblick/shopware-demo:${1}
}

push 5.7.3
push 5.7.4
push 5.7.5
push 5.7.6
push 5.7.7
