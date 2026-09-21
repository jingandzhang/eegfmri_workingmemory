# Slow oscillations and overnight working memory

Task materials and analysis code collected for **Slow Oscillations Modulate Overnight Brain Changes in Working Memory Function**, Jing Zhang, Pin-Chun Chen, Sara C. Mednick, and Arielle Tambini, *Journal of Cognitive Neuroscience* (2026), 1–22. [Article DOI](https://doi.org/10.1162/JOCN.a.2677) · [PubMed](https://pubmed.ncbi.nlm.nih.gov/42507810/).

## Release status

This contains the available task and analysis scripts EEG detection instructions are in [eeg/detection/README.md](eeg/detection/README.md). 

## Start here

- [Working-memory task instructions](task/working_memory/README.md)
- [Analysis workflow and figure mapping](docs/WORKFLOW.md)
- [Complete categorized script index](docs/SCRIPT_INDEX.md)
- [Software and input requirements](docs/DEPENDENCIES.md)
- [Reproduction gaps and release checklist](docs/REPRODUCTION_GAPS.md)
- [Source mapping and SHA-256 checksums](docs/source-manifest.json)

## Layout

```text
eeg/detection/         EEG detection and event-preparation sources
task/working_memory/   MATLAB task, sequence generator, and participant instructions
analysis/              MATLAB, Python, Jupyter, and shell analysis sources
variants/fmri/         Separate preprocessing copy retained for provenance
docs/                  Workflow, dependencies, gaps, and source manifest
tools/                 Static package validation; does not execute analyses
```

## Data and reuse

Participant data, saved results, notebooks' outputs, the internal analysis manual, and manuscript documents are not included. Necessary binary inputs and masks must be supplied or recreated as described in the documentation. No open-source license has been selected on behalf of the authors; see [third-party notices](THIRD_PARTY_NOTICES.md).
