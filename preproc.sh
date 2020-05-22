#!/bin/bash 

ID=$1
TP=$2

COGREH_DIR="$(dirname "$SUBJECTS_DIR")"

preproc-sess -s ${ID}_TP${TP} -fsd bold -surface fsaverage lhrh -mni305 -fwhm 8 -per-run -nostc -d ${COGREH_DIR}/subjects
