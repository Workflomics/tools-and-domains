cwlVersion: v1.2
class: CommandLineTool
baseCommand: magick
label: imagemagick
arguments:
  - valueFrom: "imagemagick_output.jpg"
    position: 2
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.magick_in_1)
  DockerRequirement:
    dockerPull: my-imagemagick
  InlineJavascriptRequirement: {}

inputs:
  magick_in_1:
    type: File
    format: http://edamontology.org/format_3752  # TIFF
    inputBinding:
      position: 1
      valueFrom: $(self.path)

outputs:
  magick_out_1: 
    type: File
    format: http://edamontology.org/format_3579  # JPG
    outputBinding:
      glob: "imagemagick_output.jpg"