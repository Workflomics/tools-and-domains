cwlVersion: v1.2
class: CommandLineTool
label: SAMtools (SAM to sorted BAM)

requirements:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/samtools:1.20--h50ea8bc_0
  ShellCommandRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  alignment_sam:
    type: File
    format: http://edamontology.org/format_2573  # SAM
  threads:
    type: int?
    default: 4

outputs:
  sorted_bam:
    type: File
    format: http://edamontology.org/format_2572  # BAM
    outputBinding:
      glob: sorted.bam

baseCommand: [bash, -lc]
arguments:
  - |
    set -euo pipefail
    samtools view -@ ${threads:-4} -b "$(inputs.alignment_sam.path)" \
      | samtools sort -@ ${threads:-4} -o sorted.bam
