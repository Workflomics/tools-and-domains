#!/bin/bash

cwltool --outdir output ../imagemagick-jpg-png.cwl ./input-jpg.yml

cwltool --outdir output ../imagemagick-jpg-tiff.cwl ./input-jpg.yml

cwltool --outdir output ../imagemagick-png-jpg.cwl ./input-png.yml

cwltool --outdir output ../imagemagick-png-tiff.cwl ./input-png.yml

cwltool --outdir output ../imagemagick-tiff-jpg.cwl ./input-tiff.yml

cwltool --outdir output ../imagemagick-tiff-png.cwl ./input-tiff.yml


