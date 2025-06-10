cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_pca.R
label: masspix_pca
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
      glob: "*.png"

  masspix_out_2:
    type: File
    format: "http://edamontology.org/format_3752"  #csv
    outputBinding:
      glob: "*.csv"
