#!/bin/bash
docker buildx build --tag \
  "py_template:1.1" \
  -o type=image --platform=linux/arm64,linux/amd64 --push -f Dockerfile .
