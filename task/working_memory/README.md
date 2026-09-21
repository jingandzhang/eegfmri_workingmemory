# Working-memory task

`RUN.m` launches the MATLAB `WM_v5` app with `N_repeat = 3` and `TR = 2.24` seconds. `Generate_seq.m` creates arithmetic equations, letters, and arrow baseline trials. `Intro.txt` supplies participant instructions. The interface uses MATLAB UI Figure/AppBase; it does not call Psychtoolbox in these sources.

1. Make a writable local copy of this folder, and set it as MATLAB's current folder. The app opens `Intro.txt` relative to the current folder.
2. Run `RUN` in MATLAB with desktop graphics available.
3. Enter a new test subject/run identifier, such as `demo_V1_S1_R1`.
4. Select **Generate Sequences**, or use **Choose** to select previously generated sequences. The generator creates a folder named by the identifier with four `OSPAN_*.csv`, three `Arithmetic_*.csv`, and six `Baseline_*.csv` files at the default repeat count. Each sequence contains seven rows.
5. Set the desired font sizes, select **Start**, and use the `5` key/scanner trigger to begin from the instructions screen. Response keys should match the scanner keypad and the displayed instructions.
6. The app saves `responces_<identifier>.mat` (original filename spelling) containing `responses`, `Times`, and `Main_time` in the working folder.

The default block sequence is Encoding/Maintenance → Serial Recognition → Baseline → Math → Baseline, repeated three times, followed by Encoding/Maintenance → Serial Recognition (17 blocks). Equation and arrow presentations last 3 seconds, letters/asterisks 1 second, and recognition prompts 3 seconds. Confirm display timing and trigger/key mapping on the acquisition hardware before collecting data.

The original generator does not set a random seed. Preserve generated CSV files and record the RNG state to replay a sequence; generating new stimuli is not a replay of the published participants' sequences. The historical subject identifier in the app is an example. Generated sequences and responses are excluded by `.gitignore`.

Static inspection found all directly named local task dependencies. MATLAB runtime and display timing have not been validated in this package.
