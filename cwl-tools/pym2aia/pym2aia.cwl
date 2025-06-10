cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["python3", "/usr/local/bin/m2aia_normalize.py"]
label: pym2aia
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.pym2aia_in_1)
  DockerRequirement:
    dockerPull: workflomics/pym2aia:latest

inputs:
  pym2aia_in_1:
    type: File
    format: "http://edamontology.org/format_3682"  # imzML
    inputBinding:
      prefix: -i
  
  pym2aia_in_2:
    type: File
    format: "http://edamontology.org/format_3839"  # ibd

arguments:
  - prefix: -o
    valueFrom: m2aia-normalized.imzML
  - prefix: -m
    valueFrom: "tic"

outputs:
  pym2aia_out_1:
    type: File
    format: "http://edamontology.org/format_3682"
    outputBinding:
      glob: "*.imzML"

  pym2aia_out_2: 
    type: File
    format: "http://edamontology.org/format_3839"
    outputBinding:
      glob: "*.ibd"

