cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_mass_spectra_calibration_imzml.R
label: maldiquant_mass_spectra_calibration
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
  
  ref_mz_values: # question
    type: string
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
    format: http://edamontology.org/format_3682  #imzml
    outputBinding:
      glob: "*.csv"
