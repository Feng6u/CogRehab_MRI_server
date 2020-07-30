#This R script creates paradigm files for the 7 runs of 4 MRI tasks and creates two output files (.csv and .par) for each run. 
#Created by Feng Gu in March 2019. Modified by Feng Gu in July 2020. 

################################## SETTING UP #########################################

args = commandArgs(trailingOnly=TRUE) #take user's input from the command line, when running this script in terminal. 

COGREH_DIR <- dirname(Sys.getenv("SUBJECTS_DIR")) #create a variable COGREH_DIR using the path of the CogRehab master folder. 

id <- args[1] #take user's first input as ID (e.g., CR001)

TP <- args[2] #take user's second input as TP (e.g., 1)

################################## VM_ENCODING #########################################

#loop through runs 1 and 2, and decide task number (001 vs. 002) under bold folder based on run number
for (run in 1:2) {
  
  if (run == 1){
    bold <- "001"
  } else {
    bold <- "002"
  }
  
vm <- read.delim(file.path(paste0(COGREH_DIR, '/raw_data/fMRI_behavioral_data/VM/VM_Encoding/', id, '_TP', TP, '/vm_run', run, '_', id, '_TP', TP, '.txt')), stringsAsFactors=FALSE) #read data file of vm_run1
  
vm$Category <- gsub("Control", "1", vm$Category) #change the category of "Control" to "1"
vm$Category <- gsub("Words", "2", vm$Category) #change the category of "Words" to "2"

#change data type to numeric for relavant variables
vm$Category <- as.numeric(as.character(vm$Category)) 
vm$LongFixation.OnsetTime <- as.numeric(as.character(vm$LongFixation.OnsetTime))
vm$Stimulus.OnsetTime <- as.numeric(as.character(vm$Stimulus.OnsetTime))

vm$onset <- ((vm$Stimulus.OnsetTime - vm$LongFixation.OnsetTime)/1000) #compute real onset time and create a new variable

vm$Duration <- rep(2,nrow(vm)) #create a column of value 2 for Duration

vm$Weight <- rep(1,nrow(vm)) #create a column of value 1 for Weight

vm <- data.frame(vm$onset, vm$Category, vm$Duration, vm$Weight) #only keep the relavant columns and reorder columns for FreeSurfer

write.table(vm, file.path(paste0(COGREH_DIR, '/subjects/', id, '_TP', TP, '/par_file/VM_encoding_Run', run, '.csv')), row.names=FALSE, col.names = FALSE, sep = "\t") #create a csv format of paradigm file
write.table(vm, file.path(paste0(COGREH_DIR, '/subjects/', id, '_TP', TP, '/bold/', bold, '/vm.par')), row.names=FALSE, col.names = FALSE, sep = "\t") #this is the actual paradigm file that will be used in analysis

}

################################## VM RECOGNITION #########################################

recog <- read.delim(file.path(paste0(COGREH_DIR, '/raw_data/fMRI_behavioral_data/VM/VM_Recog/', id, '_TP', TP, '/recog_', id, '_TP', TP, '.txt')), stringsAsFactors=FALSE) #read data file of vm_recog

recog$Category <- gsub("OldRelated", "1", recog$Category) #change the category of "OldRelated" to "1"
recog$Category <- gsub("NewRelated", "2", recog$Category) #change the category of "NewRelated" to "2"
recog$Category <- gsub("NewUnrelated", "3", recog$Category) #change the cateory of "NewUnrelated" to "3"

#change data type to numeric for relavant variables
recog$Category <- as.numeric(as.character(recog$Category))
recog$LongFixation.OnsetTime <- as.numeric(as.character(recog$LongFixation.OnsetTime))
recog$RecogStimulus.OnsetTime <- as.numeric(as.character(recog$RecogStimulus.OnsetTime))

recog$onset <- ((recog$RecogStimulus.OnsetTime - recog$LongFixation.OnsetTime)/1000) #compute real onset time and create a new variable

recog$Duration <- rep(2,nrow(recog)) #create a column of value 2 for duration

recog$Weight <- rep(1,nrow(recog)) #create a column of value 1 for weight

recog <- data.frame(recog$onset, recog$Category, recog$Duration, recog$Weight) #only keep the relavant columns and reorder columns for FreeSurfer

write.table(recog, file.path(paste0(COGREH_DIR, '/subjects/', id, '_TP', TP, '/par_file/recog.csv')), row.names=FALSE, col.names = FALSE, sep = "\t") #create a csv format of paradigm file
write.table(recog, file.path(paste0(COGREH_DIR, '/subjects/', id, '_TP', TP, '/bold/003/recog.par')), row.names=FALSE, col.names = FALSE, sep = "\t") #this is the actual paradigm file that will be used in analysis 

################################## EFN #########################################

#loop through runs 1 and 2, and decide task number (004 vs. 005) under bold folder based on run number
for (run in 1:2) {
  
  if (run == 1){
    bold <- "004"
  } else {
    bold <- "005"
  }

efn <- read.delim(file.path(paste0(COGREH_DIR, '/raw_data/fMRI_behavioral_data/EFN_BACK/', id, '_TP', TP, '/efn_run', run, '_', id, '_TP', TP, '.txt')), stringsAsFactors=FALSE) #read data file of efn

#change naming of picture type: neutral to 1, negative to 2
efn$PicList <- gsub("PicListNeg.", "2", efn$PicList) 
efn$PicList <- gsub("PicListNeu.", "1", efn$PicList)

#change naming of task type: 1-back to 1, 2-back to 2   
efn$ListType <- gsub("1-Back", "1", efn$ListType)
efn$ListType <- gsub("2-Back", "2", efn$ListType) 


#create conditions: 1-back & Neutral = 1, 1-back & Negative = 2, 2-back & Neutral =3, 2-back & Negative = 4
efn$condition <- ifelse(efn$ListType == 1 & efn$PicList == 1, 1,
                             ifelse(efn$ListType == 1 & efn$PicList == 2, 2,
                                    ifelse(efn$ListType == 2 & efn$PicList == 1, 3, 4)))  


efn$GetReady <- rep(efn[1,"GetReady.OnsetTime"], nrow(efn)) #create a column with the onset of start of experiment 

ind <- seq(1, nrow(efn), by=12) # make an index every 12th row
efn <- efn[ind,] #leave only the indexed rows (for block design)

#change data type to numeric 
efn$condition <- as.numeric(as.character(efn$condition))
efn$GetReady <- as.numeric(as.character(efn$GetReady))
efn$Slide3.OnsetTime <- as.numeric(as.character(efn$Slide3.OnsetTime ))

efn$onset <- ((efn$Slide3.OnsetTime - efn$GetReady)/1000) #compute real onset time and create a new variable

efn$Duration <- rep(53.5,nrow(efn)) #create a column of value 53.5 for duration

efn$Weight <- rep(1,nrow(efn)) #create a column of value 1 for weight

efn <- data.frame(efn$onset, efn$condition, efn$Duration, efn$Weight) #only keep the relavant columns and reorder columns for FreeSurfer

write.table(efn, file.path(paste0(COGREH_DIR, '/subjects/', id, '_TP', TP, '/par_file/efn_run', run, '.csv')), row.names=FALSE, col.names = FALSE, sep = "\t") #create a csv format of paradigm file
write.table(efn, file.path(paste0(COGREH_DIR, '/subjects/', id, '_TP', TP, '/bold/', bold, '/efn.par')), row.names=FALSE, col.names = FALSE, sep = "\t") #this is the actual paradigm file that will be used in analysis

}

################################## FB #########################################

#loop through runs 1 and 2, and decide task number (006 vs. 007) under bold folder based on run number
for (run in 1:2) {
  
  if (run == 1){
    bold <- "006"
  } else {
    bold <- "007"
  }

fb <- read.delim(file.path(paste0(COGREH_DIR, '/raw_data/fMRI_behavioral_data/FB/', id, '_TP', TP, '/fb_run', run, '_', id, '_TP', TP, '.txt')), stringsAsFactors=FALSE)  #read data file of fb

#change naming of conditions: belief as 1, photo as 2
fb$condition <- gsub("BeliefDisplay", "1", fb$Procedure.SubTrial.)
fb$condition <- gsub("PhotoDisplay", "2", fb$condition) 

#change data type to numeric
fb$condition <- as.numeric(as.character(fb$condition))
fb$StoryDisplay.OnsetTime <- as.numeric(as.character(fb$StoryDisplay.OnsetTime))
fb$Fixation1.OnsetTime <- as.numeric(as.character(fb$Fixation1.OnsetTime))
fb$QuestionDisplay.OnsetTime <- as.numeric(as.character(fb$QuestionDisplay.OnsetTime))

fb$onset <- ((fb$StoryDisplay.OnsetTime - fb$Fixation1.OnsetTime)/1000) #compute real onset time and create a new variable

fb$Duration <- rep(19.033,nrow(fb)) #create a column of value 19.033 for duration

fb$Weight <- rep(1,nrow(fb)) #create a column of value 1 for weight

fb <- data.frame(fb$onset, fb$condition, fb$Duration, fb$Weight)  #only keep the relavant columns and reorder columns for FreeSurfer

write.table(fb, file.path(paste0(COGREH_DIR, '/subjects/', id, '_TP', TP, '/par_file/fb_run', run, '.csv')), row.names=FALSE, col.names = FALSE, sep = "\t")   #create a csv format of paradigm file
write.table(fb, file.path(paste0(COGREH_DIR, '/subjects/', id, '_TP', TP, '/bold/', bold, '/fb.par')), row.names=FALSE, col.names = FALSE, sep = "\t")   #this is the actual paradigm file that will be used in analysis

}

################################# MESSAGE ########################################
cat(paste0('---------------------------------------------------------------------------------------------------------', '\n',
           'Sucessfully created paradigm files!!', '\n', '\n')
)  #show this message to user if everything works well 

