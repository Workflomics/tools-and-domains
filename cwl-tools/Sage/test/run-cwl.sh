#!/bin/bash

cwltool --outdir output ../sage.cwl ./input.yml

# cwltool --enable-ext --docker --debug \
#   --overrides '{"requirements": {"DockerRequirement": {"dockerVolumes": ["/var/run/docker.sock:/var/run/docker.sock"]}}}' \
#   --output output \
#   ../sage.cwl ./input.yml
