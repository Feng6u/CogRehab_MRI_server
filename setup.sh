#!/bin/bash

#This shell script creates all required folders for a specific participant at a specific time point to prepare for FreeSurfer analysis, and also copies over the MRI and behavoiral data files from FENG_DIR.
#Created by Feng Gu in September 2019. Last modified by Feng Gu in December 2020. 


###################### SETTING UP ###########################

ID=$1   #take the first argument as the variable ID
TP=$2   #take the second argument as the variable TP

if [ -z ${ID} ]    #if user forgets to input ID: 
then
        echo "---------------------------------------------------------------------------------------------------------
ERROR: Subject ID was not supplied. The subject ID (e.g., 'CR000') should be supplied as the first argument.
Example: "/bin/bash /group/guimond_CogReh/CogRehab/scripts/setup.sh CR001 1"
---------------------------------------------------------------------------------------------------------"

exit 1


elif [ -z ${TP} ]  #if user forgets to input TP: 
then
        echo "---------------------------------------------------------------------------------------------------------
ERROR: Time point was not supplied. The time point (e.g., '1' or '2') should be supplied as the second argument.
Example: "/bin/bash /group/guimond_CogReh/CogRehab/scripts/setup.sh CR001 1"
---------------------------------------------------------------------------------------------------------"

exit 2


elif [ ${#ID} -ne 5 ]  #if user enters ID incorrectly (length of ID is not equal to 5 characters): 

then 
	echo  "--------------------------------------------------------------------------------------------------------
ERROR: Please type the full ID of the particiapnt, including the letters (e.g., CR001) 
---------------------------------------------------------------------------------------------------------"

exit 3


elif [ ${#TP} -ne 1 ]  #if user enters TP incorrectly (length of TP is not equal to 1 characters):

then 
	echo  "---------------------------------------------------------------------------------------------------------
ERROR: Please type the number for time point. Please do not include the letters (e.g., 1) 
---------------------------------------------------------------------------------------------------------"

exit 4


fi


######################### DEFINING VARIABLES ##########################

BEH_DIRS="VM/VM_Encoding VM/VM_Recog EFN_BACK FB"
COGREH_DIR="$(dirname "$SUBJECTS_DIR")"
FENG_DIR="/group/guimond_CogReh/feng/CogRehab"

if [ $TP -eq 1 ] #because NM is only measured in T1
then
ONE_RUN="T1 RESTING VM/VM_Recog NM"  #these 4 MRI tasks have 1 run each. Define them as ONE_RUN
else
ONE_RUN="T1 RESTING VM/VM_Recog"  #these 3 MRI tasks have 1 run each. Define them as ONE_RUN
fi

TWO_RUNS="VM/VM_Encoding EFN_BACK FB" #these 3 MRI tasks have 2 runs each. Define them as TWO_RUNS
RUNS="Run1 Run2" #define RUNS as Run1 and Run2. Will be used to name folders

if [ $TP -eq 1 ] #because NM is only measured in T1
then
DIRS="bold anat resting nm par_file" #these are the folders needed for TP1 under "subjects" folder
else
DIRS="bold anat resting par_file" #these are the folders needed for TP2 under "subjects" folder
fi

TASKS="001 002 003 004 005 006 007" #these are folders needed under "bold" folder, one folder for each fMRI task

########################### CREATING/POPULATING FOLDERS ###########################

#for all the scans that have one run (defined as ONE_RUN), create a folder for each ID_TP, and then copy data from FENG_DIR into raw_data folder
for i in $ONE_RUN
do 

	mkdir -p $COGREH_DIR/raw_data/MRI_scan_data/$i/${ID}_TP${TP}
	cp $FENG_DIR/MRI_scan_data/$i/${ID}_TP${TP}/nii/*.nii $COGREH_DIR/raw_data/MRI_scan_data/$i/${ID}_TP${TP}

done


#for all the scans that have two runs (defined as TWO_RUNS), create a folder for each ID_TP for each run, and then copy data from FENG_DIR into raw_data folder
for i in $TWO_RUNS
do
	for o in $RUNS
	do
		mkdir -p $COGREH_DIR/raw_data/MRI_scan_data/$i/${ID}_TP${TP}/$o
		cp $FENG_DIR/MRI_scan_data/$i/${ID}_TP${TP}/$o/nii/*.nii $COGREH_DIR/raw_data/MRI_scan_data/$i/${ID}_TP${TP}/$o

	done
done


#create folders for behavorial data for each ID_TP, and then copy data from FENG_DIR into raw_data folder
for i in $BEH_DIRS
do 

	mkdir -p $COGREH_DIR/raw_data/fMRI_behavioral_data/$i/${ID}_TP${TP}
	cp $FENG_DIR/fMRI_behavioral_data/$i/${ID}_TP${TP}/* $COGREH_DIR/raw_data/fMRI_behavioral_data/$i/${ID}_TP${TP}

done



#create folders for each ID_TP under subjects folder, to prepare for FreeSurfer
for i in $DIRS
do
	mkdir -p $COGREH_DIR/subjects/${ID}_TP${TP}/$i

done


#create 7 folders (defined in TASKS) under bold, one for each run of each fMRI task
for i in $TASKS 
do 

	mkdir $COGREH_DIR/subjects/${ID}_TP${TP}/bold/$i
done


#populate folders under subjects folder (copy from FENG_DIR)
cp $FENG_DIR/MRI_scan_data/T1/${ID}_TP${TP}/nii/T1.nii $COGREH_DIR/subjects/${ID}_TP${TP}/anat
cp $FENG_DIR/MRI_scan_data/VM/VM_Encoding/${ID}_TP${TP}/Run1/nii/f.nii $COGREH_DIR/subjects/${ID}_TP${TP}/bold/001
cp $FENG_DIR/MRI_scan_data/VM/VM_Encoding/${ID}_TP${TP}/Run2/nii/f.nii $COGREH_DIR/subjects/${ID}_TP${TP}/bold/002
cp $FENG_DIR/MRI_scan_data/VM/VM_Recog/${ID}_TP${TP}/nii/f.nii $COGREH_DIR/subjects/${ID}_TP${TP}/bold/003
cp $FENG_DIR/MRI_scan_data/EFN_BACK/${ID}_TP${TP}/Run1/nii/f.nii $COGREH_DIR/subjects/${ID}_TP${TP}/bold/004
cp $FENG_DIR/MRI_scan_data/EFN_BACK/${ID}_TP${TP}/Run2/nii/f.nii $COGREH_DIR/subjects/${ID}_TP${TP}/bold/005
cp $FENG_DIR/MRI_scan_data/FB/${ID}_TP${TP}/Run1/nii/f.nii $COGREH_DIR/subjects/${ID}_TP${TP}/bold/006
cp $FENG_DIR/MRI_scan_data/FB/${ID}_TP${TP}/Run2/nii/f.nii $COGREH_DIR/subjects/${ID}_TP${TP}/bold/007
cp $FENG_DIR/MRI_scan_data/RESTING/${ID}_TP${TP}/nii/resting.nii $COGREH_DIR/subjects/${ID}_TP${TP}/resting/resting.nii

if [ $TP -eq 1 ] #because NM is only measured in T1
then
cp $FENG_DIR/MRI_scan_data/NM/${ID}_TP${TP}/nii/nm.nii $COGREH_DIR/subjects/${ID}_TP${TP}/nm/nm.nii
fi

#create a file called subjectname that contains ID_TP information for FreeSurfer
echo ${ID}_TP${TP} > $COGREH_DIR/subjects/${ID}_TP${TP}/subjectname



####################### TMS-EEG ############################
mkdir $COGREH_DIR/TMS_EEG/${ID}_TP${TP}  #create a directory for every ID_TP in TMS_EEG folder
cp $COGREH_DIR/subjects/${ID}_TP${TP}/anat/T1.nii $COGREH_DIR/TMS_EEG/${ID}_TP${TP}/  #copy T1 to the folder
cp $COGREH_DIR/scripts/normTarg.sh $COGREH_DIR/TMS_EEG/${ID}_TP${TP}/  #copy the script that creates TMS-EEG coordinates to the folder
