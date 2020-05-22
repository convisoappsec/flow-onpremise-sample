#!/usr/bin/env bash


DOCKER_NAMESPACE="convisoappsec"
CONVISO_DOCKER_REGISTRY="136214147921.dkr.ecr.us-west-2.amazonaws.com"
CONVISO_DOCKER_USER="AWS"

convisoappsec:flow:docker:pull() {
  conviso_token_file=$1

  [ ! -f "$conviso_token_file" ] && {
    echo "${conviso_token_file} is not a file!"  && exit 1
  }

  cat "$conviso_token_file" | docker login "$CONVISO_DOCKER_REGISTRY" -u "$CONVISO_DOCKER_USER" --password-stdin

  flow_app_img="${CONVISO_DOCKER_REGISTRY}/flow-app:latest"
  flow_db_img="${CONVISO_DOCKER_REGISTRY}/flow-db:latest"
  flow_web_img="${CONVISO_DOCKER_REGISTRY}/flow-web:latest"

  docker pull "$flow_app_img"
  docker pull "$flow_db_img"
  docker pull "$flow_web_img"

  docker tag "$flow_app_img" "${DOCKER_NAMESPACE}/flow"
  docker tag "$flow_db_img"  "${DOCKER_NAMESPACE}/flow-db"
  docker tag "$flow_web_img"  "${DOCKER_NAMESPACE}/flow-web"
}

convisoappsec:flow:docker:pull "${@}"
