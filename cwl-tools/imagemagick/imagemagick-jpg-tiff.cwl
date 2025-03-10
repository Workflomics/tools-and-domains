cwlVersion: v1.2
class: CommandLineTool
baseCommand: magick
label: imagemagick
arguments:
  - valueFrom: "$(inputs.magick_in_1.nameroot).tiff"
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
    format: http://edamontology.org/format_3579  # JPG
    inputBinding:
      position: 1
      valueFrom: $(self.basename)

outputs:
  magick_out_1: 
    type: File
    format: http://edamontology.org/format_3752  # TIFF
    outputBinding:
      glob: "*.tiff"