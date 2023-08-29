cwlVersion: v1.0
class: CommandLineTool
baseCommand: comet
label: comet-ms

arguments:
  - -Pcomet.params
  - valueFrom: $(inputs.Comet_in_1.nameroot)
    prefix: -N
    separate: false
inputs:
  params:
    type: File
    default:
      class: File
      path: ./comet.params
  spectra:
    type: File
    format: "http://edamontology.org/format_3244" # mzML
    inputBinding:
      position: 4
  reference_sequence:
    type: File
    format: "http://edamontology.org/format_1929" # FASTA
    inputBinding:
      position: 3
      prefix: -D
      separate: false

outputs:
    peptide_spectrum_match: 
      type: File
      format: "http://edamontology.org/format_3655" # pepXML
      outputBinding:
        glob: "*.pep.xml"
