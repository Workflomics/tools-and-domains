#!/bin/bash
set -e

conda run -n pepXML2ProteinNameList xmllint --xpath "//*[local-name()='search_hit'][@hit_rank = '"1"']/@protein_descr" $1 | cut -d '"' -f2 > protein_names.txt