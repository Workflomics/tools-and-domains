cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["bash"]
label: gprofiler
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.Params)
  DockerRequirement:
    dockerPull: spctools/tpp:version6.3.3
inputs:
  Params:
    type: File
    inputBinding:
      position: 1
    default:
      class: File
      location: https://raw.githubusercontent.com/Workflomics/tools-and-domains/main/cwl-tools/gprofiler/gprofiler.sh
  gProfiler_in_1:
    type: File
    doc: "Input file containing gene/query data"
    inputBinding:
      position: 2
outputs:
  gProfiler_out_1:
    type: File
    doc: "Output file containing the result of the curl command"
    outputBinding:
      glob: "output.json"
