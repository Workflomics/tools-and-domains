cwlVersion: v1.2
class: CommandLineTool
label: Bowtie2 (build index + align)

requirements:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/bowtie2:2.5.1--py39h3321a2d_0
  ShellCommandRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  reads_1:
    type: File
    format: http://edamontology.org/format_1930
  reads_2:
    type: File
    format: http://edamontology.org/format_1930
  reference:
    type: File
    format: http://edamontology.org/format_1929
  threads:
    type: int?
    default: 4
  extra_args:
    type: string?
    default: ""

outputs:
  alignment_sam:
    type: File
    format: http://edamontology.org/format_2573
    outputBinding:
      glob: aligned.sam

baseCommand: [bash, -lc]
arguments:
  - |
    set -euo pipefail
    bowtie2-build "$(inputs.reference.path)" ref_index
    bowtie2 -x ref_index \
      -1 "$(inputs.reads_1.path)" -2 "$(inputs.reads_2.path)" \
      -p ${threads:-4} ${extra_args:-""} \
      -S aligned.sam
