cwlVersion: v1.0
label: Sage
class: CommandLineTool
baseCommand: ["/bin/bash", "-c"]
arguments:
  - valueFrom: >
      "sage -o /data/output -f $(inputs.Sage_in_2.path) \
      $(inputs.Configuration.path) $(inputs.Sage_in_1.path)"
    shellQuote: false
requirements:
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerPull: sage:latest
    dockerOutputDirectory: /data

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
      location: config.json

outputs:
  Sage_out:
    type: File
    format: "http://edamontology.org/format_3475" # TSV    3247" # mzIdentML
    outputBinding:
      glob: /data/output/results.sage.tsv
