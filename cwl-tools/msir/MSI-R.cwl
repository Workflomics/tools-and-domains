cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["python3", "recalibration/recalibration.py"]
label: msir
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.magick_in_1)
  DockerRequirement:
    dockerPull: workflomics/msir:latest
  InlineJavascriptRequirement: {}

inputs:
  msir_in_1:
    type: File
    format: "http://edamontology.org/format_3752"  # imzml
    inputBinding:
      position: 1
      prefix: -i

  msir_in_2:
    type: File
    format: "http://edamontology.org/format_3752"  # txt
    inputBinding:
      position: 2
      prefix: --i2

arguments:
  - prefix: -o
    valueFrom: msir-recalibrated.imzML
  - prefix: -st
    valueFrom: "0.0005"
  - prefix: -tl
    valueFrom: "0.01"
  - prefix: -lm
    valueFrom: "0.002"

outputs:
  msir_out_1: 
    type: File
    format: "http://edamontology.org/format_3579"  # imzml
    outputBinding:
      glob: "*.imzML"