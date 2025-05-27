cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_mass_spectra_calibration_imzml.R
label: maldiquant
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.maldiquant_in_1)
      - $(inputs.maldiquant_in_2)
  DockerRequirement:
    dockerPull: workflomics/maldiquant:latest

inputs:
  maldiquant_in_1:
    type: File
    format: "http://edamontology.org/format_3682"  #imzml
    inputBinding:
      position: 1
      prefix: --input

  maldiquant_in_2:
    type: File
    format: "http://edamontology.org/format_3839"  #ibd
  
  ref_mz_values: 
    type: string
    default: "369.35, 798.54, 885.55, 912.58"
    inputBinding:
      position: 2
      prefix: --ref_mz

  output_file_name: 
    type: string 
    default: "calibrated_spectra.imzml"
    inputBinding: 
      position: 3
      prefix: --output
    

outputs:
  maldiquant_out_1:
    type: File
    format: "http://edamontology.org/format_3682"  #imzml
    outputBinding:
      glob: "*.imzml"

  maldiquant_out_2:
    type: File
    format: "http://edamontology.org/format_3839"  #ibd
    outputBinding:
      glob: "*.ibd"
