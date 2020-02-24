# CogRehab_MRI_server
Shell and R scripts used for MRI analyses on the BIC server at the Royal Ottawa Mental Health Center.

1. COGREH	
	- sets environment for FreeSurfer (sets FREESURFER_HOME, FSFAST_HOME and 		SUBJECTS_DIR) and navigates to the scripts folder of the CogRehab study
  - This requires some modification to the ~/.bashrc file. Needs to add the following to ~/.bashrc first: 
  alias COGREH='export SUBJECTS_DIR=/group/guimond_CogReh/CogRehab/SUBJECTS_DIR; export FREESURFER_HOME=/usr/local/freesurfer-6.0; export FSFAST_HOME=$FREESURFER_HOME/fsfast; source $FREESURFER_HOME/SetUpFreeSurfer.sh; cd /group/guimond_CogReh/CogRehab/scripts'

2. setup.sh
	- reminds to set environment for FreeSurfer
	- reminds to supply subject ID as an argument
	- copies nii and E-prime txt output to /group/guimond_CogReh/CogRehab/raw_data
	- sets up data environment for the given participant (build profile with anat, bold, resting and 	nm in /group/guimond_CogReh/CogRehab/subjects)
			- Note: Anat contains T1. Bold contains fMRI scans. NM is neuromelanin- 				sensitivity scan. Resting is resting state.
			- 001 in bold is vm encoding run1
			- 002 in bold is vm encoding run2
			- 003 in bold is vm recognition
			- 004 in bold is efn run1
			- 005 in bold is efn run2
			- 006 in bold is fb run1
			- 007 in bold is fb run2
	- creates a TMS-EEG environment for each participant (a folder for each participant with their 	T1 and script inside) 

3. recon.sh
	- recon-all for a participant

4. normTarg.sh
	- creates coordinates for TMS-EEG

5. par.R
	- creates 7 paradigm files for each participant (for vm_encoding run1, vm_encoding run2, 	vm_recognition, efn run1, efn run2, fb run1, fb run2) and saves the paradigm files into /par_file 	in /subjects as .csv files and into each directory of /bold in /subjects as .par files. 
  
6. preproc.sh
  - preprocesses fMRI scans for the participant.

7. make_analysis.sh
	- configures analyses and contrasts for each fMRI task  (defines number of conditions, names of	 paradigm files, run list files, etc.) 

8. make_contrast.sh
	- configures contrasts for each fMRI task (e.g., condition 1 – condition 2) 

9. make_selxavge.sh
	- First level analysis 

10. FS_IN_ONE.sh
	- combines steps 2-7. 
