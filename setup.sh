#!/bin/bash

ID=$1

	## verify if $SUBJECTS_DIR is set
if [ -z "$SUBJECTS_DIR" ]
	then
	echo "---------------------------------------------------------------------------------------------------------
ERROR:
\$SUBJECTS_DIR is not set. Please type "COGREH" before proceeding.
---------------------------------------------------------------------------------------------------------"

exit 1

	## verify if subject ID was supplied as argument
elif [ -z ${ID} ] 
then 
	echo "---------------------------------------------------------------------------------------------------------
ERROR: No argument was supplied. The subject ID (e.g., 'CR000') should be supplied as the first argument.
Example:  './setup.sh CR000'
---------------------------------------------------------------------------------------------------------"

exit 2

fi

MRI_DIRS="T1 RESTING VM/VM_Encoding/Run1 VM/VM_Encoding/Run2 VM/VM_Recog EFN_BACK/Run1 EFN_BACK/Run2 FB/Run1 FB/Run2 NM"
BEH_DIRS="VM/VM_Encoding VM/VM_Recog EFN_BACK FB"
COGREH_DIR="$(dirname "$SUBJECTS_DIR")"
FENG_DIR="/group/guimond_CogReh/feng/CogRehab"

for i in $MRI_DIRS

do 

mkdir -p $COGREH_DIR/raw_data/MRI_scan_data/$i/$ID

cp $FENG_DIR/MRI_scan_data/$i/$ID/nii/*.nii $COGREH_DIR/raw_data/MRI_scan_data/$i/$ID

done

for o in $BEH_DIRS

do 

mkdir -p $COGREH_DIR/raw_data/fMRI_behavioral_data/$o/$ID

cp $FENG_DIR/fMRI_behavioral_data/$o/$ID/* $COGREH_DIR/raw_data/fMRI_behavioral_data/$o/$ID

done


TASKS="001 002 003 004 005 006 007"

for i in $TASKS
do
mkdir -p $COGREH_DIR/subjects/$ID/bold/$i
done

mkdir $COGREH_DIR/subjects/$ID/anat
mkdir $COGREH_DIR/subjects/$ID/resting
mkdir $COGREH_DIR/subjects/$ID/nm
mkdir $COGREH_DIR/subjects/$ID/par_file

echo ${ID} > $COGREH_DIR/subjects/$ID/subjectname

cp $FENG_DIR/MRI_scan_data/T1/$ID/nii/T1.nii $COGREH_DIR/subjects/$ID/anat
cp $FENG_DIR/MRI_scan_data/VM/VM_Encoding/Run1/$ID/nii/f.nii $COGREH_DIR/subjects/$ID/bold/001
cp $FENG_DIR/MRI_scan_data/VM/VM_Encoding/Run2/$ID/nii/f.nii $COGREH_DIR/subjects/$ID/bold/002
cp $FENG_DIR/MRI_scan_data/VM/VM_Recog/$ID/nii/f.nii $COGREH_DIR/subjects/$ID/bold/003
cp $FENG_DIR/MRI_scan_data/EFN_BACK/Run1/$ID/nii/f.nii $COGREH_DIR/subjects/$ID/bold/004
cp $FENG_DIR/MRI_scan_data/EFN_BACK/Run2/$ID/nii/f.nii $COGREH_DIR/subjects/$ID/bold/005
cp $FENG_DIR/MRI_scan_data/FB/Run1/$ID/nii/f.nii $COGREH_DIR/subjects/$ID/bold/006
cp $FENG_DIR/MRI_scan_data/FB/Run2/$ID/nii/f.nii $COGREH_DIR/subjects/$ID/bold/007
cp $FENG_DIR/MRI_scan_data/RESTING/$ID/nii/resting.nii $COGREH_DIR/subjects/$ID/resting/resting.nii
cp $FENG_DIR/MRI_scan_data/NM/$ID/nii/f.nii $COGREH_DIR/subjects/$ID/nm/f.nii


##### TMS-EEG #####
mkdir $COGREH_DIR/TMS_EEG/$ID
cp $COGREH_DIR/subjects/$ID/anat/T1.nii $COGREH_DIR/TMS_EEG/$ID/
cp $COGREH_DIR/scripts/normTarg.sh $COGREH_DIR/TMS_EEG/$ID/

