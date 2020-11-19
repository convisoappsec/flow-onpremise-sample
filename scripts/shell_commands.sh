#!/usr/bin/env bash

CONVISO_DOCKER_USER="AWS"
CONVISO_DOCKER_REGISTRY="docker.convisoappsec.com"
CONVISO_LOCAL_REGISTRY="localhost:5000"

function convisoappsec:docker:login {
  conviso_token_file=$1

  [ ! -f "$conviso_token_file" ] && {
    echo "${conviso_token_file} is not a file!"
    return 1
  }

  cat "$conviso_token_file" | docker login "$CONVISO_DOCKER_REGISTRY" -u "$CONVISO_DOCKER_USER" --password-stdin && \
    rm -fv "$conviso_token_file"
}

function convisoappsec:docker:setup_local_registry {
  local flowcli_img="$CONVISO_DOCKER_REGISTRY/flowcli:latest"
  local sastbox_img="$CONVISO_DOCKER_REGISTRY/sastbox:latest"
  
  local local_sastbox_img="$CONVISO_LOCAL_REGISTRY/convisoappsec/sastbox:latest"
  local local_flowcli_img="$CONVISO_LOCAL_REGISTRY/convisoappsec/flowcli:latest"


  docker pull $sastbox_img && \
    docker pull $flowcli_img && \
    docker tag $sastbox_img $local_sastbox_img && \
    docker tag $flowcli_img $local_flowcli_img && \
    docker push $local_sastbox_img && \
    docker push $local_flowcli_img
}

export -f convisoappsec:docker:login
export -f convisoappsec:docker:setup_local_registry
