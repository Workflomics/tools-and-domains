#!/bin/sh

echo "Installing polystest in conda environment"
conda create -n polystest  -c bioconda -c conda-forge -c defaults polystest=1.2.2