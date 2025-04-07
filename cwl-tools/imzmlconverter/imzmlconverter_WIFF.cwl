cwlVersion: v1.2
class: CommandLineTool
baseCommand: java
label: imzmlconverter
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.imzMLConverter_in_1)
  DockerRequirement:
    dockerPull: workflomics/imzMLConverter:latest

inputs:
  Jar:
    type: File
    inputBinding:
      prefix: -jar
      position: 1
    default:
      calss: File 
      location : "/usr/local/imzmlconverter/imzMLConverter-2.1.1/jimzMLConverter-2.1.1.jar"
  
  imzMLConverter_in_1:
    type: File
    format: "http://edamontology.org/format_3710" # WIFF format
    inputBinding:
      position: 3

arguments: 
    - valueFrom: "imzML"
      position: 2
outputs:
  imzMLConverter_out_1:
    type: File
    format: "http://edamontology.org/format_3682" # imzML metadata file
    outputBinding: 
      glob: "*.imzML"
