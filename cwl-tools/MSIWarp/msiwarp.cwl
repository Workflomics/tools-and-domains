cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["python3", "/user/local/bin/run_msiwarp_alignment.py"]
label: msiwarp
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.maldiquant_in_1)
  DockerRequirement:
    dockerPull: msiwarp_workflomics

inputs:
  maldiquant_in_1:
    type: File
    format: http://edamontology.org/format_3682  #imzml
    inputBinding:
      position: 1
      prefix: --input

  maldiquant_in_2: 
    type: File?
    inputBinding: 
      position: 2
      prefix: --config

outputs:
  maldiquant_out_1:
    type: File
    format: http://edamontology.org/format_3682  #imzml
    outputBinding:
      glob: "*.imzml"
