#!/bin/bash

#This command has one input: the subject ID
# output is a text file containing the warped target coordinates in the folder where you had the T1. 
# you need to have fsl to run this script. 

subj=$1
parentdir="$(dirname "$SUBJECTS_DIR")"
pd=${parentdir}/TMS_EEG/${subj}/
T1=${pd}T1.nii


bet ${T1} ${T1}_betted
flirt -ref ${FSLDIR}/data/standard/MNI152_T1_2mm_brain -in ${T1}_betted -omat ${pd}/my_affine_transf.mat
fnirt --in=${T1} --aff=${pd}/my_affine_transf.mat --cout=${pd}/my_nonlinear_transf --config=T1_2_MNI152_2mm
applywarp --ref=${FSLDIR}/data/standard/MNI152_T1_2mm --in=${T1} --warp=${pd}/my_nonlinear_transf.nii.gz --out=${T1}_warped
echo -38 44 26 | std2imgcoord -img ${T1} -std ${FSLDIR}/data/standard/MNI152_T1_2mm -warp ${pd}/my_nonlinear_transf.nii.gz > ${pd}/warped_target.txt


