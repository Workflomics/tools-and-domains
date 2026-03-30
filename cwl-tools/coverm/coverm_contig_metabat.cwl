cwlVersion: v1.2
class: CommandLineTool
label: CoverM contig (MetaBAT depth)

requirements:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/coverm:0.7.0--h07ea13f_1
  ShellCommandRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  sorted_bam:
    type: File
    format: http://edamontology.org/format_2572  # BAM
  threads:
    type: int?
    default: 4

outputs:
  depth_tsv:
    type: File
    format: http://edamontology.org/format_3475  # TSV
    outputBinding:
      glob: depth.tsv

baseCommand: [bash, -lc]
arguments:
  - |
    set -euo pipefail
    coverm contig \
      --bam-files "$(inputs.sorted_bam.path)" \
      --methods metabat \
      --threads ${threads:-4} \
      --output-file depth.tsv
