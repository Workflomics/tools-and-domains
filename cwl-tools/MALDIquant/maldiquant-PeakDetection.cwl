cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_detect_peaks_imzml.R
label: maldiquant
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.maldiquant_in_1)
      - $(inputs.maldiquant_in_2)
  DockerRequirement:
    dockerPull: workflomics/maldiquant:latest
inputs:
  maldiquant_in_1:
    type: File
    format: "http://edamontology.org/format_3682"  #imzml
    inputBinding:
      position: 1
      prefix: --input

  maldiquant_in_2: 
    type: File
    format: "http://edamontology.org/format_3839"  #ibd

outputs:
  maldiquant_out_1:
    type: File
    format: "http://edamontology.org/format_3752"  #csv
    outputBinding:
      glob: "*.csv"
