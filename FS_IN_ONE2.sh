#!/bin/bash

#This shell script is a master FreeSurfer analysis script for a specific participant at a specific time point. This is the only script that needs to be run for CogRehab data analyses.

#It does the following things in order: 
#	1. Creates required folder for each ID_TP to prepare for FreeSurfer analysis
#	2. Copies all MRI and behavioral files from FENG_DIR to the folders of each ID_TP
#	3. recon-all for ID_TP
#	4. Computes coordinates for TMS-EEG
#	5. Pre-processing of fMRI scans
#	6. Creates paradigm files for each run of each fMRI task
#	7. first-level analysis


#Created by Feng Gu in September 2019. Modified by Feng Gu in May 2020. 


####################################################### SETTING UP ############################################

echo "Please enter participant's ID (e.g., CR001) and press [ENTER]:"  #Ask user to input particiapnt's ID

read ID  #Take user's input as the particiapnt's ID

if [ ${#ID} -ne 5 ]  #Make sure the input has the length of 5 characters

then 
	echo  "---------------------------------------------------------------------------------------------------------
ERROR: Please type the full ID of the particiapnt, including the letters (e.g., CR001) 
---------------------------------------------------------------------------------------------------------"

exit

fi


echo "Please enter the time point for ${ID} (e.g., 1) and press [ENTER]:" #Ask user to input time point

read TP #Take user's input as the time point

if [ ${#TP} -ne 1 ]  #Make sure the input has the length of 1 character

then 
	echo  "---------------------------------------------------------------------------------------------------------
ERROR: Please type the number for time point. Do not include the letters (e.g., 1) 
---------------------------------------------------------------------------------------------------------"

exit

fi


echo "Please press [ENTER] to confirm this is correct: ${ID}_TP${TP}. If incorrect, please type "N" to exit." #Give user a chance to check and change input

read confirmation

if [ "$confirmation" == "N" ] #If user enters "N", exit this program

then 
	echo "---------------------------------------------------------------------------------------------------------
Please rerun this script.
---------------------------------------------------------------------------------------------------------"

exit

else			#If user confirms the ID and TP are correct, then show this on the screen and then proceed

	echo "---------------------------------------------------------------------------------------------------------
Thank you!! Now analyzing data for ${ID}_TP${TP}....						
---------------------------------------------------------------------------------------------------------" 

fi


####################################################### DEFINING VARIABLES ############################################

COGREH_DIR="$(dirname "$SUBJECTS_DIR")"

####################################################### ANALYSIS ############################################

/bin/bash $COGREH_DIR/scripts/setup.sh $ID $TP
setup=$?
if [ $setup -ne 0 ]
then setup_msg="setup.sh was NOT executed successfully :("
fi

/bin/bash $COGREH_DIR/scripts/recon.sh $ID $TP
recon=$?
if [ $recon -ne 0 ]
then recon_msg="recon.sh was NOT executed successfully :("
fi

/bin/bash $COGREH_DIR/scripts/preproc.sh $ID $TP
preproc=$?
if [ $preproc -ne 0 ]
then preproc_msg="preproc.sh was NOT executed successfully :("
fi

Rscript $COGREH_DIR/scripts/par.R $ID $TP
par=$?
if [ $par -ne 0 ]
then par_msg="par.R was NOT executed successfully :("
fi

/bin/bash $COGREH_DIR/scripts/make_selxavg3.sh $ID $TP
selxavg=$?
if [ $selxavg -ne 0 ]
then selxavg_msg="make_selxavg3.sh was NOT executed successfully :("
fi  


####################################################### ENDING ############################################

if [ ${#setup_msg} -eq 0 ] && [ ${#recon_msg} -eq 0 ] && [ ${#preproc_msg} -eq 0 ] && [ ${#par_msg} -eq 0  ] && [ ${#selxavg_msg} -eq 0 ]

then
echo "---------------------------------------------------------------------------------------------------------
Successfully completed analyses for ${ID}_TP${TP}!
---------------------------------------------------------------------------------------------------------"

else

echo "
----------------------------------------------------------------------------------------------------------------
$setup_msg $recon_msg $preproc_msg $par_msg $selxavg_msg
-------------------------------------------------------------------------------------------------------------"

fi
