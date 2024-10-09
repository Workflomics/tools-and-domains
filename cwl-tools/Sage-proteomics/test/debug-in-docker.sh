#!/bin/bash

docker run -it --rm \
  --entrypoint /bin/bash \
  --mount=type=bind,source=/Users/peter/repos/bakeoff/containers/cwl-tools/Sage/test/data,target=/data/ \
  ghcr.io/lazear/sage:v0.14.7

# sage -o /data/output -f /data/small.fasta /data/config.json /data/small.mzML

#docker run -it --rm  -v ${PWD}:/data sage:latest /app/sage -o /data /data/config.json
