########################################################
#### MANUALLY DOWNLOADED THE FILES AND SETTING PATH 
#### ALSO MAKING A LIST OF ALL FILES                
########################################################

UCLA_path <- file.path(getwd(),"UCI HAR Dataset")
UCLA_source <-list.files(UCLA_path, recursive=TRUE)

########################################################
### READING SUBJECT DATA AND CONSOLIDATE
########################################################

SubjectTrain <- read.table(file.path(UCLA_path,"train","subject_train.txt"),header = FALSE)
SubjectTest  <- read.table(file.path(UCLA_path,"test", "subject_test.txt"),header = FALSE)
Subject_merged <- rbind(SubjectTrain,SubjectTest)
names(Subject_merged)<-c("Subject")

########################################################
### READING ACTIVITY DATA AND CONSOLIDATE
########################################################

ActivityTest  <- read.table(file.path(UCLA_path, "test" , "Y_test.txt" ),header = FALSE)
ActivityTrain <- read.table(file.path(UCLA_path, "train", "Y_train.txt"),header = FALSE)
Activity_merged <- rbind(ActivityTest,ActivityTrain)
names(Activity_merged)<-c("Activity")

########################################################
### READING FEATURES DATA AND CONSOLIDATE
########################################################

FeaturesTest  <- read.table(file.path(UCLA_path,"test" ,"X_test.txt" ),header = FALSE)
FeaturesTrain <- read.table(file.path(UCLA_path,"train", "X_train.txt"),header = FALSE)
Features_merged <- rbind(FeaturesTest,FeaturesTrain)
Features_Names <- read.table(file.path(UCLA_path, "features.txt"),head=FALSE)
names(Features_merged)<- Features_Names$V2


########################################################
### 1.MERGE the training and the test sets to create one 
### data set.
########################################################

merge_1 <- cbind(Subject_merged,Activity_merged)
merged_data_all<- cbind(merge_1, Features_merged)

########################################################
### 2.Extracts only the measurements on the mean and 
### standard deviation for each measurement.
########################################################

FeaturesNames<-Features_Names$V2[grep("mean\\(\\)|std\\(\\)", Features_Names$V2)]
selectedNames<-c(as.character(FeaturesNames), "Subject", "Activity" )
merged_data_all <-subset(merged_data_all,select=selectedNames)

########################################################
### 3.Uses descriptive activity names to name the 
### activities in the data set.
########################################################

Labels <- read.table(file.path(UCLA_path, "activity_labels.txt"),header = FALSE)
merged_data_all$activity<-factor(merged_data_all$Activity);
merged_data_all$activity<- factor(merged_data_all$Activity,labels=as.character(Labels$V2))

########################################################
### 4.Appropriately labels the data set with descriptive 
### variable names..
########################################################

#- prefix t  is replaced by  time
#- Acc is replaced by Accelerometer
#- Gyro is replaced by Gyroscope
#- prefix f is replaced by frequency
#- Mag is replaced by Magnitude
#- BodyBody is replaced by Body


names(merged_data_all)<-gsub("^t", "time", names(merged_data_all))
names(merged_data_all)<-gsub("^f", "frequency", names(merged_data_all))
names(merged_data_all)<-gsub("Acc", "Accelerometer", names(merged_data_all))
names(merged_data_all)<-gsub("Gyro", "Gyroscope", names(merged_data_all))
names(merged_data_all)<-gsub("Mag", "Magnitude", names(merged_data_all))
names(merged_data_all)<-gsub("BodyBody", "Body", names(merged_data_all))

########################################################
### 5.Creates a second, independent 
### tidy data set with the average of each variable for 
### each activity and each subject.
########################################################

library(plyr);
Datasub<-aggregate(. ~Subject + Activity,merged_data_all, mean)
Datasub<-Datasub[order(Datasub$Subject,Datasub$Activity),]
write.table(Datasub, file = "tidydata.txt",row.name=FALSE)
