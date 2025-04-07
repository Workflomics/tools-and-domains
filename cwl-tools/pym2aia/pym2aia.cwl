cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["python3", "/usr/local/bin/m2aia_normalize.py"]
label: m2aia
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.imzml_file)
  DockerRequirement:
    dockerPull: workflomics/m2aia:latest

inputs:
  m2aia_in_1:
    type: File
    format: "http://edamontology.org/format_3682"  # imzML
    inputBinding:
      prefix: -i

arguments:
  - prefix: -o
    valueFrom: m2aia-normalized.imzML
  - prefix: -m
    valueFrom: "tic"

outputs:
  m2aia_out_1:
    type: File
    format: "http://edamontology.org/format_3682"
    outputBinding:
      glob: "*.imzML"

