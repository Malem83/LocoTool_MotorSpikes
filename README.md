# LocoTool_MotorSpikes
Import EMG data from Spike2 for analysis in MATLAB. 

These scripts were written for MATLAB by Maxime Lemieux, research assistant in the laboratory of Prof. Frédéric Bretzner at Université Laval, Québec, Canada.
They process data sampled and processed by Spike2 (CED). Data were acquired with a Power3 unit. Scripts were used for peer-reviewed studies. The design requires 4 muscles (filtered traces and raster of spikes) and a timebase for stim. Scripts were intended for  longitudinal spinal cord injury studies (4 timepoints: before, week 1, week 3 and week 7). 

-----
Analysis of EMG response to 10 ms photostimulations at rest
Step 1. Export data from Spike2
The structure was planned to analysis of multiple time period (ctl, wk1, wk3, wk7), percentage of maximal laser intensity (int65), pulse duration (dur010) and number of pulses (e.g., fsin for single, f010 for 10 Hz and f100 for 100 Hz). The format and number of character is important to make the database. 

Step 2. Extract response to each photostimulation
Run script RestAnalysis.m
To test, use ‘MRF17232_rest_ctl_int65_dur010_fsin.mat’.
The output is a file called Database_17232.
Step 3. Extract response to each photostimulation
Gather all output files in a single folder and run the following scripts for number of motor units and duration
Rest_LTA_Dur.m
Rest_LTA_MUnb.m

-----
Analysis of EMG response to 10 ms photostimulations during locomotion
Note: to test step 1-3, use the following file Gi17230_ctl_loco_int60_dur010.mat

Step 1. Export Data from Spike2
4 channels of hi-passed filtered EMGs (RTA, RGL, LTA, LGL) exported from Spike2
4 channels of events (RTA_units, etc…) of spikes extracted from filtered EMGs
Stim timebase
Four files for time periods (ctl, wk1, wk3, wk7)

Step 2.  LocoAnalysis.m
Prepare the database for responses to photostimulation. 
Set a line 1 the ID of the mouse (*). Export file as  ‘*_stimtb.mat’.

Step 3. LocoAnalysis2
Set at line 1 the ID and line 2 the timepoint. 
Analyze the motor unit density, amplitude and Z-transformed in response to photostimulation. Evaluate the parameter in a time window (defaut is 50 ms) before and after photostimulation. Response is computed as the difference between after and before. 
Note: This step usually lasts less than 5 minutes. However, some file can take 2-3 hours depending on the length and number of motor spikes on all channels.
Example of visualization
 
Step 4. LocoTool_STATS
To test stats, unzip folder Gi17230_resp and place scripts in the folder.
Prepare data for stats. Data can be used for boxplot at this stage.
Output: SortedData_*.mat

Step 5. Run statistics for the longitudinal analysis
Mann-Whitney are run to compare each timepoint after SCI with pre-SCI level. Fisher test are also run to check variability. 
For excitatory activity in flexors during stance, run LocoTool_STATS_SWING.m
For excitatory activity in extensors during swing, run LocoTool_STATS_STANCE.m
For inhibitory activity in extensors, run LocoTool_STATS_STANCE.m
Results are printed in the command window.  Mean, SD and CV are stored in MUD_LTA and MUA_LTA (same for _RTA, RGL and _LGL).

Step 6. Pooled statistics
To test scripts, unzip folder Left medial MRF.

-----
Analysis of EMG response to trains of photostimulations during locomotion
Unzip 17465_data to test.
Step 1. Export data from Spike 2
In spike 2, duplicate TA EMG, rectify and smooth the signal. Name the trace ‘flexor’. Do the same for GL (rename extensor).  In the ‘Analysis’ tab, select sub-menu ’Measurements’ and ‘Data channel’, select the peak, onset and offset of the flexor burst. Name events ‘peak’, ‘onburst’ and ‘offburst’.

Step 2. Extract data and run statistics
EMGBurstAnalysis_Train_FLEX.m (peak activity, uses Wilcoxon signed rank)
EMGBurstAnalysis_Train_EXT.m (integrated activity, uses Wilcoxon signed rank)
Data are stored in the arrays STATS_CTL and STATS_WK7
