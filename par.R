args = commandArgs(trailingOnly=TRUE)

## setting paths: Requires a defined $SUBJECTS_DIR
COGREH_DIR <- dirname(Sys.getenv("SUBJECTS_DIR"))
## Verification
if(exists('COGREH_DIR') == FALSE || nchar(COGREH_DIR[1]) == 0){
  stop("Error: $SUBJECTS_DIR is empty or not defined. 
       Please define $SUBJECTS_DIR as the SUBJECTS_DIR directory in the relevant project folder."
       , call. = TRUE)
}

setwd(COGREH_DIR)
subjects <- file.path(COGREH_DIR, 'subjects/')

## Requires the participant ID as an argument
listpotentialsubjects <- basename(list.dirs(subjects, recursive = FALSE))
if (length(args)==0) {
  stop('\n', '\n', "The participant ID must be supplied as an argument.", '\n',
       paste('----------------------------------------------------------------'),
       call. = TRUE)
} else if (length(args)>=2) {
  stop('\n', '\n', "Please only supply one argument: the participant ID, e.g. CR000.", '\n',
       paste('---------------------------------------------------------------------------------------------------------'), 
       call. = TRUE)
} else if (is.element(args[1], listpotentialsubjects) == FALSE) {
  stop('\n', '\n', "The subject ID entered does not match an existing subject.
       
       Valid subjects found in the database are: ", '\n', '\n',
       paste(listpotentialsubjects, Collapse = "  "), '\n',
       paste('---------------------------------------------------------------------------------------------------------'),
       call. = TRUE)
}

id <- args[1]
cat(paste0('---------------------------------------------------------------------------------------------------------', '\n',
           'Making the paradigm files for ', id, '...', '\n', '\n')
)

################################## VM_ENCODING RUN 1 #########################################

vm_run1 <- read.delim(file.path(paste0(COGREH_DIR, '/raw_data/fMRI_behavioral_data/VM/VM_Encoding/', id, '/vm_run1_', id, '.txt')), stringsAsFactors=FALSE)

attach(vm_run1) 

vm_run1 <- data.frame (LongFixation1.OnsetTime, Stimulus.OnsetTime, Category, stringsAsFactors=FALSE)
#create a new data frame with relavant variables 

detach(vm_run1) 

vm_run1$Category <- gsub("Control", "1", vm_run1$Category)
vm_run1$Category <- gsub("Words", "2", vm_run1$Category)

vm_run1$Category <- as.numeric(as.character(vm_run1$Category))
vm_run1$LongFixation1.OnsetTime <- as.numeric(as.character(vm_run1$LongFixation1.OnsetTime))
vm_run1$Stimulus.OnsetTime <- as.numeric(as.character(vm_run1$Stimulus.OnsetTime))


vm_run1$onset <- ((vm_run1$Stimulus.OnsetTime - vm_run1$LongFixation1.OnsetTime)/1000) #compute real onset time and create a new variable

vm_run1$Duration <- rep(2,nrow(vm_run1)) #create a column of value 2 for duration

vm_run1$Weight <- rep(1,nrow(vm_run1)) #create a column of value 1 for weight

vm_run1 <- data.frame(vm_run1$onset, vm_run1$Category, vm_run1$Duration, vm_run1$Weight)


write.table(vm_run1, file.path(paste0(COGREH_DIR, '/subjects/', id, '/par_file/VM_encoding_Run1.csv')), row.names=FALSE, col.names = FALSE, sep = "\t")
write.table(vm_run1, file.path(paste0(COGREH_DIR, '/subjects/', id, '/bold/001/vm.par')), row.names=FALSE, col.names = FALSE, sep = "\t")


################################## VM_ENCODING RUN 2 #########################################

vm_run2 <- read.delim(file.path(paste0(COGREH_DIR, '/raw_data/fMRI_behavioral_data/VM/VM_Encoding/', id, '/vm_run2_', id, '.txt')), stringsAsFactors=FALSE)

attach(vm_run2) 

vm_run2 <- data.frame (LongFixation.OnsetTime, Stimulus.OnsetTime, Category, stringsAsFactors=FALSE)
#create a new data frame with relavant variables 

detach(vm_run2) 

vm_run2$Category <- gsub("Control", "1", vm_run2$Category)
vm_run2$Category <- gsub("Words", "2", vm_run2$Category)

vm_run2$Category <- as.numeric(as.character(vm_run2$Category))
vm_run2$LongFixation.OnsetTime <- as.numeric(as.character(vm_run2$LongFixation.OnsetTime))
vm_run2$Stimulus.OnsetTime <- as.numeric(as.character(vm_run2$Stimulus.OnsetTime))

vm_run2$onset <- ((vm_run2$Stimulus.OnsetTime - vm_run2$LongFixation.OnsetTime)/1000) #compute real onset time and create a new variable

vm_run2$Duration <- rep(2,nrow(vm_run2)) #create a column of value 2 for duration

vm_run2$Weight <- rep(1,nrow(vm_run2)) #create a column of value 1 for weight

vm_run2 <- data.frame(vm_run2$onset, vm_run2$Category, vm_run2$Duration, vm_run2$Weight)

write.table(vm_run2, file.path(paste0(COGREH_DIR, '/subjects/', id, '/par_file/VM_encoding_Run2.csv')), row.names=FALSE, col.names = FALSE, sep = "\t")
write.table(vm_run2, file.path(paste0(COGREH_DIR, '/subjects/', id, '/bold/002/vm.par')), row.names=FALSE, col.names = FALSE, sep = "\t")

################################## VM RECOGNITION #########################################

recog <- read.delim(file.path(paste0(COGREH_DIR, '/raw_data/fMRI_behavioral_data/VM/VM_Recog/', id, '/recog_', id, '.txt')), stringsAsFactors=FALSE)

attach(recog) 

recog <- data.frame (LongFixation.OnsetTime, RecogStimulus.OnsetTime, Category, stringsAsFactors=FALSE)
#create a new data frame with relavant variables 

detach(recog) 

recog$Category <- gsub("OldRelated", "1", recog$Category)
recog$Category <- gsub("NewRelated", "2", recog$Category)
recog$Category <- gsub("NewUnrelated", "3", recog$Category)

recog$Category <- as.numeric(as.character(recog$Category))
recog$LongFixation.OnsetTime <- as.numeric(as.character(recog$LongFixation.OnsetTime))
recog$RecogStimulus.OnsetTime <- as.numeric(as.character(recog$RecogStimulus.OnsetTime))

recog$onset <- ((recog$RecogStimulus.OnsetTime - recog$LongFixation.OnsetTime)/1000) #compute real onset time and create a new variable

recog$Duration <- rep(2,nrow(recog)) #create a column of value 2 for duration

recog$Weight <- rep(1,nrow(recog)) #create a column of value 1 for weight

recog <- data.frame(recog$onset, recog$Category, recog$Duration, recog$Weight)

write.table(recog, file.path(paste0(COGREH_DIR, '/subjects/', id, '/par_file/recog.csv')), row.names=FALSE, col.names = FALSE, sep = "\t")
write.table(recog, file.path(paste0(COGREH_DIR, '/subjects/', id, '/bold/003/recog.par')), row.names=FALSE, col.names = FALSE, sep = "\t")

################################## EFN RUN 1 #########################################

efn_run1 <- read.delim(file.path(paste0(COGREH_DIR, '/raw_data/fMRI_behavioral_data/EFN_BACK/', id, '/efn_run1_', id, '.txt')), stringsAsFactors=FALSE)

attach(efn_run1) 

efn_run1 <- data.frame(GetReady.OnsetTime, ListType, PicList, Slide3.OnsetTime, stringsAsFactors=FALSE)

detach(efn_run1)

efn_run1$PicList <- gsub("PicListNeg.", "2", efn_run1$PicList)
efn_run1$PicList <- gsub("PicListNeu.", "1", efn_run1$PicList) #change neutral to 1, negative to 2 
efn_run1$ListType <- gsub("1-Back", "1", efn_run1$ListType)
efn_run1$ListType <- gsub("2-Back", "2", efn_run1$ListType) #change 1-back to 1, 2-back to 2 


efn_run1$condition <- ifelse(efn_run1$ListType == 1 & efn_run1$PicList == 1, 1,
                             ifelse(efn_run1$ListType == 1 & efn_run1$PicList == 2, 2,
                                    ifelse(efn_run1$ListType == 2 & efn_run1$PicList == 1, 3, 4)))  
#create conditions: 1-back & Neutral = 1, 1-back & Negative = 2, 2-back & Neutral =3, 2-back & Negative = 4

efn_run1$GetReady <- rep(efn_run1[1,1],nrow(efn_run1)) #create a column with the onset of start of experiment 

ind <- seq(1, nrow(efn_run1), by=12) # make an index every 12th row
efn_run1 <- efn_run1[ind,] #leave only the indexed rows (for block design)

efn_run1$condition <- as.numeric(as.character(efn_run1$condition))
efn_run1$GetReady <- as.numeric(as.character(efn_run1$GetReady))
efn_run1$Slide3.OnsetTime <- as.numeric(as.character(efn_run1$Slide3.OnsetTime ))

efn_run1$onset <- ((efn_run1$Slide3.OnsetTime - efn_run1$GetReady)/1000) #compute real onset time and create a new variable

efn_run1$Duration <- rep(53.5,nrow(efn_run1)) #create a column of value 53.5 for duration

efn_run1$Weight <- rep(1,nrow(efn_run1)) #create a column of value 1 for weight

efn_run1 <- data.frame(efn_run1$onset, efn_run1$condition, efn_run1$Duration, efn_run1$Weight) #only keep the relavant columns

write.table(efn_run1, file.path(paste0(COGREH_DIR, '/subjects/', id, '/par_file/efn_run1.csv')), row.names=FALSE, col.names = FALSE, sep = "\t")
write.table(efn_run1, file.path(paste0(COGREH_DIR, '/subjects/', id, '/bold/004/efn.par')), row.names=FALSE, col.names = FALSE, sep = "\t")

################################## EFN RUN 2 #########################################

efn_run2 <- read.delim(file.path(paste0(COGREH_DIR, '/raw_data/fMRI_behavioral_data/EFN_BACK/', id, '/efn_run2_', id, '.txt')), stringsAsFactors=FALSE)

attach(efn_run2) 

efn_run2 <- data.frame(GetReady.OnsetTime, ListType, PicList, Slide3.OnsetTime, stringsAsFactors=FALSE)

detach(efn_run2)

efn_run2$PicList <- gsub("PicListNeg.", "2", efn_run2$PicList)
efn_run2$PicList <- gsub("PicListNeu.", "1", efn_run2$PicList) #change neutral to 1, negative to 2 
efn_run2$ListType <- gsub("1-Back", "1", efn_run2$ListType)
efn_run2$ListType <- gsub("2-Back", "2", efn_run2$ListType) #change 1-back to 1, 2-back to 2 


efn_run2$condition <- ifelse(efn_run2$ListType == 1 & efn_run2$PicList == 1, 1,
                             ifelse(efn_run2$ListType == 1 & efn_run2$PicList == 2, 2,
                                    ifelse(efn_run2$ListType == 2 & efn_run2$PicList == 1, 3, 4)))  
#create conditions: 1-back & Neutral = 1, 1-back & Negative = 2, 2-back & Neutral =3, 2-back & Negative = 4

efn_run2$GetReady <- rep(efn_run2[1,1],nrow(efn_run2)) #create a column with the onset of start of experiment 

ind <- seq(1, nrow(efn_run2), by=12) # make an index every 12th row
efn_run2 <- efn_run2[ind,] #leave only the indexed rows (for block design)

efn_run2$condition <- as.numeric(as.character(efn_run2$condition))
efn_run2$GetReady <- as.numeric(as.character(efn_run2$GetReady))
efn_run2$Slide3.OnsetTime <- as.numeric(as.character(efn_run2$Slide3.OnsetTime ))

efn_run2$onset <- ((efn_run2$Slide3.OnsetTime - efn_run2$GetReady)/1000) #compute real onset time and create a new variable

efn_run2$Duration <- rep(53.5,nrow(efn_run2)) #create a column of value 2 for duration

efn_run2$Weight <- rep(1,nrow(efn_run2)) #create a column of value 1 for weight

efn_run2 <- data.frame(efn_run2$onset, efn_run2$condition, efn_run2$Duration, efn_run2$Weight) #only keep the relavant columns

write.table(efn_run2, file.path(paste0(COGREH_DIR, '/subjects/', id, '/par_file/efn_run2.csv')), row.names=FALSE, col.names = FALSE, sep = "\t")
write.table(efn_run2, file.path(paste0(COGREH_DIR, '/subjects/', id, '/bold/005/efn.par')), row.names=FALSE, col.names = FALSE, sep = "\t")

################################## FB RUN 1 #########################################

fb_run1 <- read.delim(file.path(paste0(COGREH_DIR, '/raw_data/fMRI_behavioral_data/FB/', id, '/fb_run1_', id, '.txt')), stringsAsFactors=FALSE)

attach(fb_run1)

fb_run1 <- data.frame(Fixation1.OnsetTime, Fixation.OnsetTime.SubTrial., StoryDisplay.OnsetTime, QuestionDisplay.OnsetTime, Procedure.SubTrial.)

detach(fb_run1)

fb_run1$condition <- gsub("BeliefDisplay", "1", fb_run1$Procedure.SubTrial.)
fb_run1$condition <- gsub("PhotoDisplay", "2", fb_run1$condition) #belief as 1, photo as 2

fb_run1$condition <- as.numeric(as.character(fb_run1$condition))
fb_run1$StoryDisplay.OnsetTime <- as.numeric(as.character(fb_run1$StoryDisplay.OnsetTime))
fb_run1$Fixation1.OnsetTime <- as.numeric(as.character(fb_run1$Fixation1.OnsetTime))
fb_run1$QuestionDisplay.OnsetTime <- as.numeric(as.character(fb_run1$QuestionDisplay.OnsetTime))

fb_run1$onset <- ((fb_run1$StoryDisplay.OnsetTime - fb_run1$Fixation1.OnsetTime)/1000) #compute real onset time and create a new variable

fb_run1$Duration <- rep(19.033,nrow(fb_run1)) #create a column of value 19.033 for duration

fb_run1$Weight <- rep(1,nrow(fb_run1)) #create a column of value 1 for weight

fb_run1 <- data.frame(fb_run1$onset, fb_run1$condition, fb_run1$Duration, fb_run1$Weight)

write.table(fb_run1, file.path(paste0(COGREH_DIR, '/subjects/', id, '/par_file/fb_run1.csv')), row.names=FALSE, col.names = FALSE, sep = "\t")
write.table(fb_run1, file.path(paste0(COGREH_DIR, '/subjects/', id, '/bold/006/fb.par')), row.names=FALSE, col.names = FALSE, sep = "\t")

################################## FB RUN 2 #########################################

fb_run2 <- read.delim(file.path(paste0(COGREH_DIR, '/raw_data/fMRI_behavioral_data/FB/', id, '/fb_run2_', id, '.txt')), stringsAsFactors=FALSE)

attach(fb_run2)

fb_run2 <- data.frame(Fixation1.OnsetTime, Fixation.OnsetTime.SubTrial., StoryDisplay.OnsetTime, QuestionDisplay.OnsetTime, Procedure.SubTrial.)

detach(fb_run2)

fb_run2$condition <- gsub("BeliefDisplay", "1", fb_run2$Procedure.SubTrial.)
fb_run2$condition <- gsub("PhotoDisplay", "2", fb_run2$condition) #belief as 1, photo as 2

fb_run2$condition <- as.numeric(as.character(fb_run2$condition))
fb_run2$StoryDisplay.OnsetTime <- as.numeric(as.character(fb_run2$StoryDisplay.OnsetTime))
fb_run2$Fixation1.OnsetTime <- as.numeric(as.character(fb_run2$Fixation1.OnsetTime))
fb_run2$QuestionDisplay.OnsetTime <- as.numeric(as.character(fb_run2$QuestionDisplay.OnsetTime))

fb_run2$onset <- ((fb_run2$StoryDisplay.OnsetTime - fb_run2$Fixation1.OnsetTime)/1000) #compute real onset time and create a new variable

fb_run2$Duration <- rep(19.033,nrow(fb_run2)) #create a column of value 19.033 for duration

fb_run2$Weight <- rep(1,nrow(fb_run2)) #create a column of value 1 for weight

fb_run2 <- data.frame(fb_run2$onset, fb_run2$condition, fb_run2$Duration, fb_run2$Weight)

write.table(fb_run2, file.path(paste0(COGREH_DIR, '/subjects/', id, '/par_file/fb_run2.csv')), row.names=FALSE, col.names = FALSE, sep = "\t")
write.table(fb_run2, file.path(paste0(COGREH_DIR, '/subjects/', id, '/bold/007/fb.par')), row.names=FALSE, col.names = FALSE, sep = "\t")


################################# MESSAGE ########################################
cat(paste0('---------------------------------------------------------------------------------------------------------', '\n',
           'Sucessfully Completed!', '\n', '\n')
)
