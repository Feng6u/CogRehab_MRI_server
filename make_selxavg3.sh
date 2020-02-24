#/bin/bash

ID=$1

	## verify if subject ID was supplied as argument
if [ -z ${ID} ] 

then 
	echo "---------------------------------------------------------------------------------------------------------
ERROR: No argument was supplied. The subject ID (e.g., 'CR000') should be supplied as the first argument.
Example:  './make_selxavg3.sh CR000'
---------------------------------------------------------------------------------------------------------"

exit

fi


COGREH_DIR="$(dirname "$SUBJECTS_DIR")"


cd ${COGREH_DIR}/subjects/${ID}/bold/

echo 001 > vmruns 
echo 002 >> vmruns 
echo 003 > recogruns 
echo 004 > efnruns 
echo 005 >> efnruns
echo 006 > fbruns
echo 007 >> fbruns 


cd ${COGREH_DIR}/mkanalysis
selxavg3-sess -s ${ID} -analysis vm.lh -d ${COGREH_DIR}/subjects &
selxavg3-sess -s ${ID} -analysis vm.rh -d ${COGREH_DIR}/subjects & 
selxavg3-sess -s ${ID} -analysis vm.mni -d ${COGREH_DIR}/subjects &
selxavg3-sess -s ${ID} -analysis recog.lh -d ${COGREH_DIR}/subjects &
selxavg3-sess -s ${ID} -analysis recog.rh -d ${COGREH_DIR}/subjects & 
selxavg3-sess -s ${ID} -analysis recog.mni -d ${COGREH_DIR}/subjects &
selxavg3-sess -s ${ID} -analysis efn.lh -d ${COGREH_DIR}/subjects &
selxavg3-sess -s ${ID} -analysis efn.rh -d ${COGREH_DIR}/subjects & 
selxavg3-sess -s ${ID} -analysis efn.mni -d ${COGREH_DIR}/subjects &
selxavg3-sess -s ${ID} -analysis fb.lh -d ${COGREH_DIR}/subjects &
selxavg3-sess -s ${ID} -analysis fb.rh -d ${COGREH_DIR}/subjects & 
selxavg3-sess -s ${ID} -analysis fb.mni -d ${COGREH_DIR}/subjects &
cd ${COGREH_DIR}/scripts
