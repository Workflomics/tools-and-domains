# WorkflowNo_1
# This workflow is generated by APE (https://github.com/sanctuuary/APE).
cwlVersion: v1.2
class: Workflow

label: WorkflowNo_1
doc: A workflow including the tool(s) Comet, PeptideProphet, ProteinProphet.

inputs:
  input_1:
    type: File
    format: "http://edamontology.org/format_3244" # mzML
  input_2:
    type: File
    format: "http://edamontology.org/format_1929" # FASTA
steps:
  Comet_01:
    run: https://raw.githubusercontent.com/Workflomics/tools-and-domains/refs/heads/main/cwl-tools/comet/comet.cwl
    in:
      Comet_in_1: input_1
      Comet_in_2: input_2
    out: [Comet_out_1, Comet_out_2, Comet_out_3]
  PeptideProphet_02:
    run: https://raw.githubusercontent.com/Workflomics/tools-and-domains/refs/heads/main/cwl-tools/peptideprophet/peptideprophet.cwl
    in:
      PeptideProphet_in_1: Comet_01/Comet_out_1
      PeptideProphet_in_2: input_1
      PeptideProphet_in_3: input_2
    out: [PeptideProphet_out_1, PeptideProphet_out_2]
  ProteinProphet_03:
    run: https://raw.githubusercontent.com/Workflomics/tools-and-domains/refs/heads/main/cwl-tools/ProteinProphet/ProteinProphet.cwl
    in:
      ProteinProphet_in_1: PeptideProphet_02/PeptideProphet_out_1
      ProteinProphet_in_2: input_2
    out: [ProteinProphet_out_1, ProteinProphet_out_2]
outputs:
  output_1:
    type: File
    format: "http://edamontology.org/format_3475" # TSV_p
    outputSource: ProteinProphet_03/ProteinProphet_out_1
