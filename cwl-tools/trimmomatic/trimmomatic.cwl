cwlVersion: v1.2
class: CommandLineTool
baseCommand:  [trimmomatic, PE]
label: trimmomatic

requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.forward_reads)
      - $(inputs.reverse_reads)
  DockerRequirement:
    dockerPull: quay.io/biocontainers/trimmomatic:0.39--hdfd78af_2

$namespaces:
  edam: http://edamontology.org/

intent:
  - http://edamontology.org/operation_3192   # Sequence trimming

inputs:
  forward_reads:
    type: File
    format: edam:format_1930              # FASTQ
    edam:data_0006: edam:data_2044        # Sequence reads
    inputBinding:
      position: 1
      valueFrom: $(self.basename)

  reverse_reads:
    type: File
    format: edam:format_1930              # FASTQ
    edam:data_0006: edam:data_2044        # Sequence reads
    inputBinding:
      position: 2
      valueFrom: $(self.basename)

  forward_paired_name:
    type: string
    default: "R1_paired.fastq.gz"
    inputBinding:
      position: 3

  forward_unpaired_name:
    type: string
    default: "R1_unpaired.fastq.gz"
    inputBinding:
      position: 4

  reverse_paired_name:
    type: string
    default: "R2_paired.fastq.gz"
    inputBinding:
      position: 5

  reverse_unpaired_name:
    type: string
    default: "R2_unpaired.fastq.gz"
    inputBinding:
      position: 6

  trimming_parameters:
    type: string?
    inputBinding:
      position: 7

outputs:
  Trimmomatic_out_forward_paired:
    type: File
    format: edam:format_1930
    edam:data_0006: edam:data_2044
    outputBinding:
      glob: $(inputs.forward_paired_name)

  Trimmomatic_out_forward_unpaired:
    type: File
    format: edam:format_1930
    edam:data_0006: edam:data_2044
    outputBinding:
      glob: $(inputs.forward_unpaired_name)

  Trimmomatic_out_reverse_paired:
    type: File
    format: edam:format_1930
    edam:data_0006: edam:data_2044
    outputBinding:
      glob: $(inputs.reverse_paired_name)

  Trimmomatic_out_reverse_unpaired:
    type: File
    format: edam:format_1930
    edam:data_0006: edam:data_2044
    outputBinding:
      glob: $(inputs.reverse_unpaired_name)

   
