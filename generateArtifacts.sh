#!/bin/bash
docker buildx build --tag \
  "$spaceRepo:1.0.${"$"}JB_SPACE_EXECUTION_NUMBER"+"$spaceRepo:latest" \
  -o type=image --platform=linux/arm64,linux/amd64 --push -f Dockerfile .
