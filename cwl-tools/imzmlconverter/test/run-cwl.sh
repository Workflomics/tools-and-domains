#!/bin/bash

cwltool --outdir output ../imzmlconverter_Thermo.cwl ./input-thermo.yml

cwltool --outdir output ../imzmlconverter_Waters.cwl ./input-waters.yml

cwltool --outdir output ../imzmlconverter_WIFF.cwl ./input-wiff.yml