#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["xmllint", "--xpath",  "//*[local-name()='search_hit'][@hit_rank = '"1"']/@protein_descr"]
requirements:
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerPull: pipelinecomponents/xmllint
    dockerOutputDirectory: /data
arguments:
- valueFrom: "| cut -d '|' -f2 > output_pepXml2ProteinNameList.txt"
  position: 2
  shellQuote: false

inputs:
  pepXml2ProteinNameList_in_1:
    type: File
    format: "http://edamontology.org/format_3655" # protXML
    inputBinding:
      position: 1

outputs:
  pepXml2ProteinNameList_out_1:
    type: File
    format: "http://edamontology.org/format_2330" # Textual format
    outputBinding:
      glob: "output_pepXml2ProteinNameList.txt"

