####################################################################
## Prerequisite: Data download, define file path and load dataset. #
####################################################################

# DEFINE CONSTANT
### ENTER YOUR OWN PATH HERE, OTHERWISE SOURCE THE FILE FROM D:\ ###
WORKING_DIR<-"D:\\" 
LOADOPTIONS_TABLE<-"TABLE"


# Load utils.R which contains the common functions that I use frequently.
utilsFileName<-"utils.R"
utilsPath<-paste(getwd(),utilsFileName,sep="//")
source(utilsPath)

# Download and unzip files to current working directory
downloadURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFileName<-"C3W4_AssDataset.zip"
targetZip<-paste(getwd(),destFileName,sep="//")
destDir<-getwd()

util_downloadNUnzip(downloadURL,destFileName,targetZip,destDir,TRUE)

# Define file path for each file needed for this assignment.
path_XTest<-"\\UCI HAR Dataset\\test\\X_test.txt"
path_YTest<-"\\UCI HAR Dataset\\test\\Y_test.txt"
path_SubjectTest<-"\\UCI HAR Dataset\\test\\subject_test.txt"
path_XTrain<-"\\UCI HAR Dataset\\train\\X_train.txt"
path_YTrain<-"\\UCI HAR Dataset\\train\\Y_train.txt"
path_SubjectTrain<-"\\UCI HAR Dataset\\train\\subject_train.txt"
path_ActivityLabels<-"\\UCI HAR Dataset\\activity_labels.txt"
path_Features<-"\\UCI HAR Dataset\\features.txt"

# Load dataset to custom variables

# Load test sets
xTest<-util_loadData(path_XTest,LOADOPTIONS_TABLE)
yTest<-util_loadData(path_YTest,LOADOPTIONS_TABLE)
subjectTest<-util_loadData(path_SubjectTest,LOADOPTIONS_TABLE)

# Load train sets
xTrain<-util_loadData(path_XTrain,LOADOPTIONS_TABLE)
yTrain<-util_loadData(path_YTrain,LOADOPTIONS_TABLE)
subjectTrain<-util_loadData(path_SubjectTrain,LOADOPTIONS_TABLE)

# Load activity labels and features
activityLabels<-util_loadData(path_ActivityLabels,LOADOPTIONS_TABLE)
features<-util_loadData(path_Features,LOADOPTIONS_TABLE)

# Define column names for each dataset. Column names for train and test datasets 
# to be define after merged.
names(activityLabels)<-c("ActivityID","ActivityName")
names(features)<-c("FeatureNumber", "FeatureName")


##################################################################
## 1.Merge the training and the test sets to create one data set #
##################################################################

# Merge train and test datasets
merged_X<-bind_rows(xTrain,xTest)
merged_Y<-bind_rows(yTrain,yTest)
merged_Subject<-bind_rows(subjectTrain,subjectTest)

# Remove unused variables.
rm(list=c("xTrain","xTest","yTrain","yTest","subjectTrain","subjectTest"))

# Define column names for the datasets
names(merged_X)<-make.names(features$FeatureName, unique = TRUE)
names(merged_Y)<-c("ActivityID")
names(merged_Subject)<-c("SubjectID")

# Merge all custom datasets into 1 final dataset
runData<-bind_cols(merged_Subject, merged_Y, merged_X)

# Remove unused variables.
rm(list=c("merged_Subject","merged_Y","merged_X","features"))


##############################################################################################
## 2.Extracts only the measurements on the mean and standard deviation for each measurement. #
##############################################################################################

runData<-select(runData,SubjectID,ActivityID,contains("mean",ignore.case = TRUE), contains("std",ignore.case = TRUE))
runData<-select(runData,-contains("angle",ignore.case = TRUE), -contains("meanFreq",ignore.case = TRUE))
        

##############################################################################
## 3.Uses descriptive activity names to name the activities in the data set. #
##############################################################################

runData<-merge(activityLabels,runData,by = "ActivityID",all.x = TRUE) 
runData<-arrange(runData,SubjectID)

# Remove unused variables.
rm(list=c("activityLabels"))

#########################################################################
## 4.Appropriately labels the data set with descriptive variable names. #
#########################################################################

names(runData)<-gsub("-"," ",names(runData))
names(runData)<-gsub("\\."," ",names(runData))
names(runData)<-gsub("\\(\\)","",names(runData))
names(runData)<-gsub("^t","Time ",names(runData))
names(runData)<-gsub("^f","Frequency ",names(runData))
names(runData)<-gsub("mean","MEAN",names(runData))
names(runData)<-gsub("std","STD",names(runData))


###############################################################################
## 5.From the data set in step 4, creates a second, independent tidy data set #
##   with the average of each variable for each activity and each subject.    #
###############################################################################

tidyData<-group_by(runData,SubjectID,ActivityID,ActivityName)
tidyData<-summarise_each(tidyData,funs(mean))

write.table(tidyData, file="tidy.txt", row.names=FALSE)
