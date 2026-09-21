# EEG detection and event preparation

`HN_SO_detection.m` corresponds to the manuscript's 0.7–1.4 Hz band and Hilbert phase jumps greater than 6. It calls `HN_EEG_burst.m`, `edfread.m`, and EEGLAB functions. 

## HN detector inputs and setup

- Install the compatible EEGLAB release and required MATLAB signal-processing functions. The detector calls `smooth`; confirm the implementation available in the original environment.
- Put cleaned EDF data and scoring MAT files in the configured `Data_dir` (default `DataForHamid/`). Scoring is read from `stageData.stages`, using 30-second epochs and stage labels 2 and 3 for N2/N3.
- Set `edf_file` and `score_file` in MATLAB before invoking the script; their example assignments are commented out. Configure `Data_dir` and `Out_dir`, and create the output directory (`OUT/HN_SO/` by default).
- Ensure the provided `edfread.m` is the reader used (`which edfread -all`). The detector expects its two-output header/record API, not a different MATLAB EDF reader. It uses `header.samples(CH)` as the sampling frequency; verify EDF record duration and the cleaned-data sampling rate.
- Run the selected detector on a working copy and verify `events_slow_S2`, `events_slow_S3`, troughs, channels, and density fields in its output before using them downstream. Empty/no-event recordings need explicit testing: `HN_EEG_burst.m` indexes the first detected start/end without an empty-result guard.

## Connecting to fMRI

`analysis/so_sp_truncated.m` consumes `OUT/HN_SO/<name>_SO.mat`, `OUT/HN_spindle/<name>_spindle.mat`, and NREM chunk timings. It assumes 250 Hz, channel index 4, and an explicitly supplied EEG–MRI offset. Confirm these values for each recording. The current alignment script requires spindle output too, even for a later SO analysis; `HN_Spindle_detection.m` is included.

Next use the verified event-generation and merging variants to create the first-level onset files. Both this directory and `analysis/` contain `events_so_sp.m` and `merge_onsets.m`; their provenance is preserved. `select_contrast.m` selects columns 1 and 4 of names/onsets/durations and appends `_nrem` to filenames. Establish that these columns match the chosen SO model before running.

Coupling implementations and the alternative Python spindle detector are retained as supporting/historical sources. Inclusion does not mean those analyses are reported in the article. EEG artifact correction and sleep scoring are manual/proprietary stages described in the manuscript, not implemented by these scripts.
