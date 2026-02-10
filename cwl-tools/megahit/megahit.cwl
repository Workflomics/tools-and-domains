cwlVersion: v1.2
class: CommandLineTool
baseCommand: megahit
label: MEGAHIT

requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.reads_1)
      - $(inputs.reads_2)
  DockerRequirement:
    dockerPull: quay.io/biocontainers/megahit:1.2.9--h8b12597_0

$namespaces:
  edam: http://edamontology.org/

intent:
  - http://edamontology.org/operation_0524  # De-novo assembly

inputs:
  reads_1:
    type: File
    format: edam:format_1930            # FASTQ
    edam:data_0006: edam:data_2044      # Sequence reads
    inputBinding:
      position: 1
      prefix: -1
      separate: true

  reads_2:
    type: File
    format: edam:format_1930
    edam:data_0006: edam:data_2044
    inputBinding:
      position: 2
      prefix: -2
      separate: true

  output_prefix:
    type: string
    default: "megahit_out"
    inputBinding:
      position: 3
      prefix: -o
      separate: true

outputs:
  contigs_fasta:
    type: File
    format: edam:format_1929            # FASTA
    edam:data_0006: edam:data_0925      # Sequence assembly (contigs)
    outputBinding:
      glob: $(inputs.output_prefix)/final.contigs.fa
