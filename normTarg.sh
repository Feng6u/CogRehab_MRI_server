#!/bin/bash

#This shell script creates coordinates used for TMS-EEG 

#The final output is a text file containing the warped target coordinates in the folder where you had the T1. 
# you need to have fsl to run this script. 

#Created by Dr. Lauri Tuominen in 2019. Modified by Feng in May 2020. 

ID=$1 #takes first input as ID
TP=$2 #takes second input as TP

COGREH_DIR="$(dirname "$SUBJECTS_DIR")" #defines COGREH_DIR
pd=${COGREH_DIR}/TMS_EEG/${ID}_TP${TP}/ #this is the folder for the input of T1 and the output of txt file
T1=${pd}T1.nii #tells the script the location of T1 file


bet ${T1} ${T1}_betted
flirt -ref ${FSLDIR}/data/standard/MNI152_T1_2mm_brain -in ${T1}_betted -omat ${pd}/my_affine_transf.mat
fnirt --in=${T1} --aff=${pd}/my_affine_transf.mat --cout=${pd}/my_nonlinear_transf --config=T1_2_MNI152_2mm
applywarp --ref=${FSLDIR}/data/standard/MNI152_T1_2mm --in=${T1} --warp=${pd}/my_nonlinear_transf.nii.gz --out=${T1}_warped
echo -38 44 26 | std2imgcoord -img ${T1} -std ${FSLDIR}/data/standard/MNI152_T1_2mm -warp ${pd}/my_nonlinear_transf.nii.gz > ${pd}/warped_target.txt


