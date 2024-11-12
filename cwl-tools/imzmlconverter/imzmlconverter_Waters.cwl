cwlVersion: v1.2
class: CommandLineTool
baseCommand: java
label: imzMLConverter
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.imzMLConverter_in_1)
  DockerRequirement:
    dockerPull: imzMLConverter

inputs:
  Jar:
    type: File
    inputBinding:
      prefix: -jar
      position: 1
    default:
      calss: File 
      location : "/usr/local/imzmlconverter/imzMLConverter-2.1.1/jimzMLConverter-2.1.1.jar"
  
  Data_type: 
    type: string
    inputBinding:
      position: 2
    default: imzML
  
  Properties_file:
    type: File
    inputBinding: 
      position: 3
      prefix: -p

  imzMLConverter_in_1:
    type: File
    format: "http://edamontology.org/format_3858" # Waters RAW
    inputBinding:
      position: 4

outputs:
  imzMLConverter_out_1:
    type: File
    format: "http://edamontology.org/format_3682" # imzML metadata file
    outputBinding: 
      glob: "*.imzML"
