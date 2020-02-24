#!/bin/bash 

ID=$1

COGREH_DIR="$(dirname "$SUBJECTS_DIR")"

preproc-sess -s ${ID} -fsd bold -surface fsaverage lhrh -mni305 -fwhm 8 -per-run -nostc -d ${COGREH_DIR}/subjects


