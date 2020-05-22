#/bin/bash

ID=$1
TP=$2

COGREH_DIR="$(dirname "$SUBJECTS_DIR")"


cd ${COGREH_DIR}/subjects/${ID}_TP${TP}/bold/

echo 001 > vmruns 
echo 002 >> vmruns 
echo 003 > recogruns 
echo 004 > efnruns 
echo 005 >> efnruns
echo 006 > fbruns
echo 007 >> fbruns 


cd ${COGREH_DIR}/mkanalysis
selxavg3-sess -s ${ID}_TP${TP} -analysis vm.lh -d ${COGREH_DIR}/subjects &
selxavg3-sess -s ${ID}_TP${TP} -analysis vm.rh -d ${COGREH_DIR}/subjects & 
selxavg3-sess -s ${ID}_TP${TP} -analysis vm.mni -d ${COGREH_DIR}/subjects &
selxavg3-sess -s ${ID}_TP${TP} -analysis recog.lh -d ${COGREH_DIR}/subjects &
selxavg3-sess -s ${ID}_TP${TP} -analysis recog.rh -d ${COGREH_DIR}/subjects & 
selxavg3-sess -s ${ID}_TP${TP} -analysis recog.mni -d ${COGREH_DIR}/subjects &
selxavg3-sess -s ${ID}_TP${TP} -analysis efn.lh -d ${COGREH_DIR}/subjects &
selxavg3-sess -s ${ID}_TP${TP} -analysis efn.rh -d ${COGREH_DIR}/subjects & 
selxavg3-sess -s ${ID}_TP${TP} -analysis efn.mni -d ${COGREH_DIR}/subjects &
selxavg3-sess -s ${ID}_TP${TP} -analysis fb.lh -d ${COGREH_DIR}/subjects &
selxavg3-sess -s ${ID}_TP${TP} -analysis fb.rh -d ${COGREH_DIR}/subjects & 
selxavg3-sess -s ${ID}_TP${TP} -analysis fb.mni -d ${COGREH_DIR}/subjects
