#!/bin/bash
docker buildx build --tag \
  "py_template:1.1" \
  --push -f Dockerfile .
