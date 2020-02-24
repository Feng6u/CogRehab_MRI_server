ID=$1

if [ -z $ID ]
then
        echo "---------------------------------------------------------------------------------------------------------
ERROR: No argument was supplied. The subject ID (e.g., 'CR000') should be supplied as the first argument.
Example:  '/bin/bash /home/cranilab/Documents/CRANI/Active_Studies/CogRehab/Analyses/Bash_scripts/CR_backup.sh CR000'
---------------------------------------------------------------------------------------------------------"

exit 1

elif [ $ID == "CR000" ]
then 
	 echo "---------------------------------------------------------------------------------------------------------
ERROR: Participant CR000 does not exist. Please modify the participant ID. 
---------------------------------------------------------------------------------------------------------"

exit 2
fi


COGREH_DIR="$(dirname "$SUBJECTS_DIR")"

/bin/bash $COGREH_DIR/scripts/setup.sh $ID &&
/bin/bash $COGREH_DIR/scripts/recon.sh $ID &&
/bin/bash $COGREH_DIR/TMS_EEG/$ID/normTarg.sh $ID &&
/bin/bash $COGREH_DIR/scripts/preproc.sh $ID &&
Rscript $COGREH_DIR/scripts/par.R $ID &&
/bin/bash $COGREH_DIR/scripts/make_selxavg3.sh $ID &&

echo "Successfully completed analyses for ${ID}!"
