cwlVersion: v1.0
label: Sage
class: CommandLineTool
baseCommand: ["/bin/bash", "-c"]
arguments:
  - valueFrom: >
      "sage -o /data/output -f $(inputs.Sage_in_1.path) \
      $(inputs.Configuration.path) $(inputs.Sage_in_2.path)"
    shellQuote: false
requirements:
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerPull: sage:latest
    dockerOutputDirectory: /data

inputs:
  Sage_in_1:
    type: File
    format: "http://edamontology.org/format_1929" # FASTA
    inputBinding:
      position: 1
      prefix: -f
  Sage_in_2:
    type: File
    format: "http://edamontology.org/format_3244" # mzML
    inputBinding:
      position: 3
  Configuration:
    type: File
    format: "http://edamontology.org/format_3464" # JSON
    inputBinding:
      position: 2

outputs:
  Sage_out:
    type: File
    format: "http://edamontology.org/format_3475" # TSV    3247" # mzIdentML
    outputBinding:
      glob: /data/output/results.sage.tsv
