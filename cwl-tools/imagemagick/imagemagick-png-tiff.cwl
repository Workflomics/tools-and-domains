cwlVersion: v1.2
class: CommandLineTool
baseCommand: magick
label: imagemagick
arguments:
  - valueFrom: "$(inputs.imagemagick_in_1.nameroot).tiff"
    position: 2
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.imagemagick_in_1)
  DockerRequirement:
    dockerPull: workflomics/imagemagick:latest
  InlineJavascriptRequirement: {}

inputs:
  imagemagick_in_1:
    type: File
    format: "http://edamontology.org/format_3603"  # PNG
    inputBinding:
      position: 1
      valueFrom: $(self.basename)

outputs:
  imagemagick_out_1: 
    type: File
    format: "http://edamontology.org/format_3752"  # TIFF
    outputBinding:
      glob: "*.tiff"