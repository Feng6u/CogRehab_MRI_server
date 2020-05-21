#!/bin/bash

ID=$1

TP=$2

COGREH_DIR="$(dirname "$SUBJECTS_DIR")"

recon-all -i $COGREH_DIR/subjects/${ID}_TP${TP}/anat/T1.nii -s ${ID}_TP${TP} -all -parallel
