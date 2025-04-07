cwlVersion: v1.2
class: CommandLineTool
baseCommand: magick
label: imagemagick
arguments:
  - valueFrom: "$(inputs.magick_in_1.nameroot).png"
    position: 2
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.magick_in_1)
  DockerRequirement:
    dockerPull: workflomics/imagemagick:latest
  InlineJavascriptRequirement: {}

inputs:
  magick_in_1:
    type: File
    format: "http://edamontology.org/format_3752"  # TIFF
    inputBinding:
      position: 1
      valueFrom: $(self.basename)

outputs:
  magick_out_1: 
    type: File
    format: "http://edamontology.org/format_3603"  # PNG
    outputBinding:
      glob: "*.png"