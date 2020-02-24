#!/bin/bash

ID=$1

COGREH_DIR="$(dirname "$SUBJECTS_DIR")"

recon-all -i $COGREH_DIR/subjects/$ID/anat/T1.nii -s $ID -all -parallel









