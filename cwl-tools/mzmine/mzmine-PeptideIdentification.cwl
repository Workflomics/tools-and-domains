cwlVersion: v1.2
class: CommandLineTool
baseCommand: /opt/mzmine/bin/mzmine
label: MZmine
requirements:
  ShellCommandRequirement: {}
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.MZmine_in_1)
      - entryname: batchfile.xml
        entry: |
          ${
            var batchfileContents = inputs.batchfile.contents;
            var inputFilePath = inputs.MZmine_in_1.path;
            batchfileContents = batchfileContents.replace(
              /<file>.*<\/file>/,
              `<file>${inputFilePath}</file>`
            );
            return batchfileContents;
          }
  DockerRequirement:
    dockerPull: MZmine

inputs:
  batchfile:
    type: File
    inputBinding:
      prefix: -batch
      position: 1
      valueFrom: $(runtime.outdir + "/batchfile.xml")

  MZmine_in_1:
    type: File
    format: "http://edamontology.org/format_3244" # mzML
    
outputs:
  MZmine_out_1:
    type: File
    format: "http://edamontology.org/format_3752" # CSV
    outputBinding:
      glob: "*.csv"
