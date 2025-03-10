cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_visualization_imzml.R
label: maldiquant_visualization
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.maldiquant_in_1)
  DockerRequirement:
    dockerPull: quay.io/biocontainers/r-maldiquant:1.18--r341ha44fe06_0

inputs:
  maldiquant_in_1:
    type: File
    format: http://edamontology.org/format_3682  #imzml
    inputBinding:
      position: 1
      prefix: --input

  maldiquant_in_2: 
    type: double 
    inputBinding:
      position: 2
      prefix: --target_mz

  tolerance:
    type: double
    default: 0.5
    inputBinding:
      position: 3
      prefix: --tolerance

  output_file: 
    type: string
    default: "ion_image.png"
    inputBinding:
      position: 4
      prefix: --output 

outputs:
  maldiquant_out_1:
    type: File
    format: http://edamontology.org/format_3603  #png
    outputBinding:
      glob: "*.png"
