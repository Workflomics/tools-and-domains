cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqc
label: FastQC

requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.fastq_file)
  DockerRequirement:
    dockerPull: biocontainers/fastqc:v0.11.9_cv8

$namespaces:
  edam: http://edamontology.org/

intent:
  - http://edamontology.org/operation_3218  # Sequencing quality control

inputs:
  fastq_file:
    type: File
    format: edam:format_1930        # FASTQ
    edam:data_0006: edam:data_2044  # Sequence read
    inputBinding:
      position: 1
      valueFrom: $(self.basename)

outputs:
  fastqc_html:
    type: File
    format: edam:format_2331        # HTML
    edam:data_0006: edam:data_2048  # Report
    outputBinding:
      glob: "*_fastqc.html"

  fastqc_zip:
    type: File
    format: edam:format_3987        # ZIP archive
    edam:data_0006: edam:data_2048  # Report
    outputBinding:
      glob: "*_fastqc.zip"
