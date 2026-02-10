cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkm
label: CheckM

requirements:
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.2--pyhdfd78af_1
  InitialWorkDirRequirement:
    listing:
      - $(inputs.bins_dir)
  EnvVarRequirement:
    envDef:
      - envName: CHECKM_DATA_PATH
        envValue: $(inputs.checkm_data_dir.path)

$namespaces:
  edam: http://edamontology.org/

intent:
  - http://edamontology.org/operation_3180  # Sequence assembly validation

arguments:
  - lineage_wf
  - --tab_table

inputs:
  checkm_data_dir:
    type: Directory
    doc: "CheckM reference data directory (database)."
    inputBinding: {}

  bins_dir:
    type: Directory
    doc: "Directory containing bins (FASTA files)."

  extension:
    type: string
    default: "fa"
    inputBinding:
      prefix: --extension

  threads:
    type: int
    default: 4
    inputBinding:
      prefix: --threads

  report_tsv:
    type: string
    default: "checkm_lineage_wf.tsv"
    inputBinding:
      prefix: --file

  output_dir:
    type: string
    default: "checkm_out"
    inputBinding: {}

outputs:
  checkm_report:
    type: File
    format: edam:format_3475           # TSV
    edam:data_0006: edam:data_2048     # Report
    outputBinding:
      glob: $(inputs.report_tsv)

  checkm_output_dir:
    type: Directory
    outputBinding:
      glob: $(inputs.output_dir)


