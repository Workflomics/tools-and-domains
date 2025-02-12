cwlVersion: v1.0
label: ms_amanda
class: CommandLineTool
baseCommand: ["/bin/bash", "-c"]
arguments:
  - valueFrom: >
      "/msamanda/MSAmanda -s $(inputs.MS_Amanda_in_1.path) \
      -d $(inputs.MS_Amanda_in_2.path) \
      -e $(inputs.Settings) \
      -f $(inputs.FileFormat) \
      -o $(inputs.OutputFile) && \
      gunzip output.mzid.gz"
    shellQuote: false
requirements:
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerPull: workflomics/msamanda:latest
    dockerOutputDirectory: /data

inputs:
  MS_Amanda_in_1:
    type: File
    format: "http://edamontology.org/format_3244" # mzML
  MS_Amanda_in_2:
    type: File
    format: "http://edamontology.org/format_1929" # FASTA
  Settings:
    type: string
    default: /msamanda/settings.xml
  FileFormat:
    type: int
    default: 2  # .mzid=2, .csv=1
  OutputFile:
    type: string
    default: "/data/output"

outputs:
  MS_Amanda_out_1:
    type: File
    format: "http://edamontology.org/format_3247" # mzIdentML
    outputBinding:
      glob: /data/output.mzid
