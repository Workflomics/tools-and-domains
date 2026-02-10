cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabat2
label: MetaBAT2

requirements:
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerPull: quay.io/biocontainers/metabat2:2.15--h986a166_1  # example tag :contentReference[oaicite:4]{index=4}

$namespaces:
  edam: http://edamontology.org/

intent:
  - http://edamontology.org/operation_3798  # Read binning :contentReference[oaicite:5]{index=5}

inputs:
  contigs_fasta:
    type: File
    format: edam:format_1929           # FASTA (same as MEGAHIT output)
    edam:data_0006: edam:data_0925     # Sequence assembly (contigs)
    inputBinding:
      prefix: -i
      position: 1

  depth_tsv:
    type: File
    format: edam:format_3475           # TSV :contentReference[oaicite:6]{index=6}
    edam:data_0006: edam:data_2048     # Report (placeholder) :contentReference[oaicite:7]{index=7}
    inputBinding:
      prefix: -a
      position: 2

  out_prefix:
    type: string
    default: "bin"
    inputBinding:
      prefix: -o
      position: 3

outputs:
  bins_fasta:
    type: File[]
    format: edam:format_1929
    edam:data_0006: edam:data_0925
    outputBinding:
      glob: $(inputs.out_prefix)*.fa

