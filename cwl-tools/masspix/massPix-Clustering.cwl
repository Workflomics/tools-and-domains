cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_clustering.R
label: masspix_clustering
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.masspix_in_1)
  DockerRequirement:
    dockerPull: workflomics/masspix:latest

inputs:
  masspix_in_1:
    type: File
    format: "http://edamontology.org/format_3752"  #csv
    inputBinding:
      position: 1
      prefix: --input


outputs:
  masspix_out_1:
    type: File
    format: "http://edamontology.org/format_3603"  #png
    outputBinding:
      glob: "*.csv"
