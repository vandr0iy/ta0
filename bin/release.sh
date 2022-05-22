#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [[ -z "${TAG}" ]]; then
  echo "TAG env var is not set. Can't release"
  exit 1
fi

DOCKER_TAG="${ECR_REGISTRY}/${ECR_REPOSITORY}:${TAG}"

echo "building the docker image for ta0…"
just build "${DOCKER_TAG}"
echo "DONE"

echo "pushing to ECR…"
docker tag "$DOCKER_TAG" "${ECR_REGISTRY}/${ECR_REPOSITORY}:latest"
docker push "${DOCKER_TAG}"
docker push "${ECR_REGISTRY}/${ECR_REPOSITORY}:latest"
echo "::set-output name=docker_image::$DOCKER_TAG"
echo "DONE"

echo "test deploy on ECS FARGATE…"
just deploy test $TAG
echo "DONE"

