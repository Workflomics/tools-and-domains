cwlVersion: v1.2
class: CommandLineTool
# baseCommand: ["python", "/usr/local/bin/run_msiwarp_alignment.py"]
label: msiwarp
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.msiwarp_in_1)
      - $(inputs.msiwarp_in_2)
  DockerRequirement:
    dockerPull: workflomics/msiwarp:latest

inputs:
  msiwarp_in_1:
    type: File
    format: "http://edamontology.org/format_3682"  #imzml
    inputBinding:
      position: 1
      prefix: --input

  msiwarp_in_2:
    type: File
    format: "http://edamontology.org/format_3839"  #ibd
  
  msiwarp_config_file: 
    type: File?
    inputBinding: 
      position: 2
      prefix: --config

outputs:
  msiwarp_out_1:
    type: File
    format: "http://edamontology.org/format_3682"  #imzml
    outputBinding:
      glob: "*.imzML"
  
  msiwarp_out_2:
    type: File
    format: "http://edamontology.org/format_3839"  #ibd
    outputBinding:
      glob: "*.ibd"
