#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: XTandem.cwl
baseCommand: ["mkdir", "-p", "/tmp/xtandem"]
requirements:
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerPull: spctools/tpp:version6.3.3
  InitialWorkDirRequirement:
    listing:
      - entryname: tandem.params
        entry: $(inputs.Params)
      - entryname: taxonomy.xml
        entry: $(inputs.Taxonomy)
      - entryname: mzmlFile.mzML
        entry: $(inputs.XTandem_in_1)
      - entryname: fastaFile.fasta
        entry: $(inputs.XTandem_in_2)
arguments:
    - valueFrom:    "&& cp tandem.params taxonomy.xml mzmlFile.mzML fastaFile.fasta /tmp/xtandem && \
                    tandem /tmp/xtandem/tandem.params && \
                    Tandem2XML /tmp/xtandem/tandemFile.tandem > mzmlFile.pep.xml"
      position: 1
      shellQuote: false
inputs:
  Params:
    type: File
    default:
      class: File
      location: https://raw.githubusercontent.com/Workflomics/tools-and-domains/docker/cwl/tools/xtandem/tandem.params
  Taxonomy:
    type: File
    default:
      class: File
      location: https://raw.githubusercontent.com/Workflomics/tools-and-domains/docker/cwl/tools/xtandem/taxonomy.xml
    
  XTandem_in_1:
    type: File
    format: "http://edamontology.org/format_3244" # mzML
  XTandem_in_2:
    type: File
    format: "http://edamontology.org/format_1929" # FASTA

outputs:
  XTandem_out_1:
    type: File
    format: "http://edamontology.org/format_3655" # pepXML
    outputBinding:
      glob: "mzmlFile.pep.xml"