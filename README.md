# LocoTool_MotorSpikes
Import EMG data from Spike2 for analysis in MATLAB. 

These scripts were written for MATLAB by Maxime Lemieux, research assistant in the laboratory of Prof. Frédéric Bretzner at Université Laval, Québec, Canada.
They process data sampled and processed by Spike2 (CED). Data were acquired with a Power3 unit. Scripts were used for peer-reviewed studies. The design requires 4 muscles (filtered traces and raster of spikes) and a timebase for stim. Scripts were intended for  longitudinal spinal cord injury studies (4 timepoints: before, week 1, week 3 and week 7). 

The file Gi17230_ctl_loco_int60_dur010.mat is provided to test steps 1-3 
1. Run LocoAnalysis.m to import data and preprocess the database.
2. Run LocoAnalysis2.m to process the data. It calls the script 2a, 2b and 2c. Script 2a evaluates the stimulation phase within the step cycle (0 to 1, triggered on flexor burst). Script are run for each timepoint. The ID and timepoint must be set at lines 1 and 2. Script 2b computes the response in terms of motor unit density and amplitude. Finally, 2c sorts data according to the phase or the occurrence of stops occurring before or after stimulation. Data are vizualised for each timepoint. Export units density, amplitude and Z-transformed data as '.mat'.  
3. Optional. LocoTool_MUD revaluates the motor unit density to set a threshold used in 2a (ongoing locomotion or a stop?). 



4. Run LocoTool_STATS.m to prepare data for statistical tests.
5. LocoTool_STATS_STANCE to evaluate the response of flexor during stance. 
6. LocoTool_STATS_SWINGE to evaluate the response of extensor during swing.
7. LocoTool_STATS_GLINH to evaluate the inhibition of the extensor during stance.
8. LocoEx_LTAphasedep provide a figure for background activity vs. phase and another one for the response vs. phase
9. LocoTool_Example gives color-coded matrices at different timepoint 

Once each timepoint of a given individual have been processed, transfer '_resp.mat' in a separate folder for vizualization of pooled data.
