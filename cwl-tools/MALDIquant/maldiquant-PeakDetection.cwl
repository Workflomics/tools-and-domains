cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["Rscript", "/usr/local/bin/run_detect_peaks_imzml.R"]
label: maldiquant_peaks_detection
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.maldiquant_in_1)
  DockerRequirement:
    dockerPull: maldiquant_peaks_imzml:latest

inputs:
  maldiquant_in_1:
    type: File
    format: http://edamontology.org/format_3682  #imzml
    inputBinding:
      position: 1
      prefix: --input

outputs:
  peaks_csv:
    type: File
    format: http://edamontology.org/format_2752  #csv
    outputBinding:
      glob: "peak_detection_results.csv"
