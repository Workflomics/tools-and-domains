cwlVersion: v1.2
class: CommandLineTool
baseCommand: magick
label: imagemagick
arguments:
  - valueFrom: "imagemagick_output.png"
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
    format: "https://edamontology.github.io/edam-browser/format_3752"  # TIFF
    inputBinding:
      position: 1
      valueFrom: $(self.path)

outputs:
  magick_out_1: 
    type: File
    format: "https://edamontology.github.io/edam-browser/format_3603"  # PNG
    outputBinding:
      glob: "imagemagick_output.png"