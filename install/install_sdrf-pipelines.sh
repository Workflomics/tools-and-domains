#!/bin/sh

echo "Installing sdrf-pipelines in conda environment"

conda create -n sdrf-pipelines  -c bioconda -c conda-forge -c defaults sdrf-pipelines=0.0.21=1.22.0



