#!/bin/bash
set -e

mkdir /tmp/xtandem && \
wget -O /tmp/xtandem/tandem.params https://raw.githubusercontent.com/Workflomics/tools-and-domains/main/cwl-tools/xtandem/tandem.params &&  \
wget -O /tmp/xtandem/taxonomy.xml https://raw.githubusercontent.com/Workflomics/tools-and-domains/main/cwl-tools/xtandem/taxonomy.xml && \
cp /data/inputs/up00000062.fasta /tmp/xtandem/fastaFile.fasta && \
cp /data/inputs/2021-10-8_Ecoli.mzML /tmp/xtandem/mzmlFile.mzML && \
/usr/local/tpp/bin/tandem /tmp/xtandem/tandem.params && \
/usr/local/tpp/bin/Tandem2XML /tmp/xtandem/tandemFile.tandem > output.pep.xml