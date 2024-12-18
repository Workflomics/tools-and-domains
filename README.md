
# Workflomics - domain and tool descriptions

This repository contains the domain and tool descriptions needed to generate and execute workflows in the [Workflomics](https://github.com/Workflomics/workflomics-frontend) interface.

To add new domains or tools to the `Workflomics` environment, CWL files and other files needed to run these tools should be added to this repository. For a detailed description of the steps that this requires, have a look at the [Workflomics documentation](https://workflomics.readthedocs.io/en/latest/index.html), under 'Domain Expert Guide'

The repository is organized in the following way:

- `domains/`: Contains the domain descriptions. The descriptions are used by the Workflomics environment to generate workflows. Each domain comprises a set of tools (e.g., described in `tools.json` file) and a configuraion file (e.g., `config.json`) that specifies the domain-specific parameters. See the [domain annotation guide](https://workflomics.readthedocs.io/en/latest/domain-expert-guide/domain-development.html) to learn more about these files.

- `cwl-tools/`: Contains the CWL CommandLineTool descriptions of the tools used in the workflows (similar to the [bio-cwl-tools](https://github.com/common-workflow-library/bio-cwl-tools) repo). The CWL files are used by the Workflomics environment to execute each step of the workflow. Within the Workflomics ecosystem these workflows are executed using the [Workflomics Benchmarker](https://github.com/Workflomics/workflomics-benchmarker) which utilizes [cwltool](https://github.com/common-workflow-language/cwltool). For more information about adding new tools, see the [adding tools section](https://workflomics.readthedocs.io/en/latest/domain-expert-guide/adding-tools.html) of the documentation.

- `examples/`: Contains example workflows that can be executed using the [Workflomics Benchmarker](https://github.com/Workflomics/workflomics-benchmarker). The workflows were generated by the Workflomics platform are written in the [Common Workflow Language (CWL)](https://www.commonwl.org/).

When using Workflomics web interface, workflows are referencing this repository directly. They are downloaded during the workflow execution, so you don't need to clone this repository for normal usage in the Workflomics environment.

## Testing

To test the CWL annotations, run `test_cwl_annotations.sh` in the repository root. This script runs the test scripts in the 'test' directory of each tool, testing whether the CWL annotations pass as stand-alone workflow steps. This requires `cwltool` and `docker` to be installed.
