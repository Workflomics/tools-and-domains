cwlVersion: v1.0
label: Sage
class: CommandLineTool
baseCommand: ["/bin/bash", "-c"]
arguments:
  - valueFrom: >
      "sage -o /data/output -f $(inputs.Sage_in_2.path) \
      $(inputs.Configuration.path) $(inputs.Sage_in_1.path) && \
      /data/sage_TSV_to_mzIdentML.sh /data/output/results.sage.tsv"
    shellQuote: false
requirements:
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerPull: ghcr.io/lazear/sage:v0.14.7
    dockerOutputDirectory: /data
  InitialWorkDirRequirement:
    listing:
      - class: File
        location: sage_TSV_to_mzIdentML.sh
        basename: sage_TSV_to_mzIdentML.sh

inputs:
  Sage_in_1:
    type: File
    format: "http://edamontology.org/format_3244" # mzML
  Sage_in_2:
    type: File
    format: "http://edamontology.org/format_1929" # FASTA
  Configuration:
    type: File
    format: "http://edamontology.org/format_3464" # JSON
    default:
      class: File
      format: "http://edamontology.org/format_3464" # JSON
      location: https://raw.githubusercontent.com/Workflomics/tools-and-domains/main/cwl-tools/Sage-proteomics/config.json

outputs:
  Sage_out:
    type: File
    format: "http://edamontology.org/format_3247" # mzIdentML
    outputBinding:
      glob: /data/output/results.sage.mzid
