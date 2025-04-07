cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_spectal_analysis.R
label: masspix_spectral_analysis
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


outputs:
  masspix_out_1:
    type: File
    format: "http://edamontology.org/format_3752"  #csv
    outputBinding:
      glob: "*.csv"
