cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["python3", "recalibration/recalibration.py"]
label: msir
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.msir_in_1)
      - $(inputs.msir_in_2)
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
    format: "http://edamontology.org/format_3839"  # ibd

  msir_in_3:
    type: File
    format: "http://edamontology.org/format_2330"  # txt
    inputBinding:
      position: 2
      prefix: -i2

  config_file:
    type: File
    default:
      class: File
      location: "https://raw.githubusercontent.com/Workflomics/tools-and-domains/msi/cwl-tools/msir/config_file_default.json"

outputs:
  msir_out_1: 
    type: File
    format: "http://edamontology.org/format_3579"  # imzml
    outputBinding:
      glob: "*.imzML"

  msir_out_2:
    type: File
    format: "http://edamontology.org/format_3839"  # ibd
    outputBinding:
      glob: "*.ibd"