#!/usr/bin/env bash
set -e

push() {
    docker push codeblick/shopware-demo:${1}
}

docker login -u ${DOCKER_USER} -p ${DOCKER_PASSWORD}

push 5.6.6
push 5.6.7
push 5.6.8
