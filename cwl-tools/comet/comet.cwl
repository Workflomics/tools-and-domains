cwlVersion: v1.2
class: CommandLineTool
baseCommand: comet
label: comet-ms
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.Comet_in_1)
      - $(inputs.Comet_in_2)
      - $(inputs.Params)
  DockerRequirement:
    dockerPull: spctools/tpp:version6.3.3
  
$namespaces:
  edam: http://edamontology.org/

intent:
  - http://edamontology.org/operation_3646  # Operation performed: Peptide database search
  - http://edamontology.org/operation_3631  # Operation performed: Peptide identification
    
inputs:
  Params:
    type: File
    inputBinding:
      prefix: -P
      position: 1
      separate: false
    default:
      class: File
      location: https://raw.githubusercontent.com/Workflomics/tools-and-domains/main/cwl-tools/comet/comet.params
  Comet_in_1:
    type: File
    format: edam:format_3244  # Data in format: mzML
    edam:data_0006: edam:data_0943  # Type of data: Mass spectrum
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
  Comet_in_2:
    type: File
    format: edam:format_1929  # Data in format: FASTA
    edam:data_0006: edam:data_2976  # Type of data: Protein sequence
    inputBinding:
      position: 2
      prefix: -D
      separate: false
      valueFrom: $(self.basename)


outputs:
    Comet_out_1: 
      type: File
      format: edam:format_3655  # Data in format: pepXML
      edam:data_0006: edam:data_0945  # Type of data: Peptide identification
      outputBinding:
        glob: "*.pep.xml"
    Comet_out_2: 
      type: File
      format: edam:format_3247  # Data in format: mzIdentML
      edam:data_0006: edam:data_0945  # Type of data: Peptide identification
      outputBinding:
        glob: "*.mzid"
    Comet_out_3: 
      type: File
      format: edam:format_3475  # Data in format: tsv
      edam:data_0006: edam:data_0945  # Type of data: Peptide identification
      outputBinding:
        glob: "*.txt"