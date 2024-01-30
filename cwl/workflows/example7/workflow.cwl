# WorkflowNo_6
# This workflow is generated by APE (https://github.com/sanctuuary/APE).
cwlVersion: v1.2
class: Workflow

label: WorkflowNo_6
doc: A workflow including the tool(s) XTandem, mzRecal, Comet, PeptideProphet, ProteinProphet.

inputs:
  input1:
    type: File
    format: "http://edamontology.org/format_3244" # mzML
  input2:
    type: File
    format: "http://edamontology.org/format_1929" # FASTA
steps:
  XTandem1:
    run: https://raw.githubusercontent.com/Workflomics/containers/docker/cwl/tools/XTandem/XTandem.cwl
    in:
      XTandem_in_1: input1
      XTandem_in_2: input2
    out: [XTandem_out_1]
  mzRecal2:
    run: https://raw.githubusercontent.com/Workflomics/containers/docker/cwl/tools/mzRecal/mzRecal.cwl
    in:
      mzRecal_in_1: input1
      mzRecal_in_2: XTandem1/XTandem_out_1
    out: [mzRecal_out_1]
  Comet3:
    run: https://raw.githubusercontent.com/Workflomics/containers/docker/cwl/tools/Comet/Comet.cwl
    in:
      Comet_in_1: mzRecal2/mzRecal_out_1
      Comet_in_2: input2
    out: [Comet_out_1]
  PeptideProphet4:
    run: https://raw.githubusercontent.com/Workflomics/containers/docker/cwl/tools/PeptideProphet/PeptideProphet.cwl
    in:
      PeptideProphet_in_1: Comet3/Comet_out_1
    out: [PeptideProphet_out_1]
  ProteinProphet5:
    run: https://raw.githubusercontent.com/Workflomics/containers/docker/cwl/tools/ProteinProphet/ProteinProphet.cwl
    in:
      ProteinProphet_in_1: PeptideProphet4/PeptideProphet_out_1
    out: [ProteinProphet_out_1]
outputs:
  output1:
    type: File
    format: "http://edamontology.org/format_3747" # protXML
    outputSource: ProteinProphet5/ProteinProphet_out_1
