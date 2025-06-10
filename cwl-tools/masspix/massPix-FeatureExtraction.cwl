cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_feature_extraction.R
label: masspix_feature_extraction
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.masspix_in_1)
  DockerRequirement:
    dockerPull: workflomics/masspix:latest

inputs:
  masspix_in_1:
    type: File
    format: "http://edamontology.org/format_3682"  #imzml
    inputBinding:
      position: 1
      prefix: --input

  masspix_in_2:
    type: File
    format: "http://edamontology.org/format_3839"  #ibd

outputs:
  masspix_out_1:
    type: File
    format: "http://edamontology.org/format_3752"  #csv
    outputBinding:
      glob: "*.csv"
