#!/bin/bash

docker run -it --rm \
  --entrypoint /bin/bash \
  --mount=type=bind,source=/Users/peter/repos/bakeoff/containers/cwl-tools/Sage/data,target=/data/ \
  sage:latest 

# sage -o /data/output -f /data/small.fasta /data/config.json /data/small.mzML

#docker run -it --rm  -v ${PWD}:/data sage:latest /app/sage -o /data /data/config.json
