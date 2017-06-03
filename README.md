# C3W4_Project

###-----------START-----------###

# Hi, thank you for reviewing my work. Below are three simple steps that will help you
# review my work smoothly.

# Step - 1:
# Download both of the scripts (run_analysis.R and utils.R) to D:\ or your desired working
# directory.

# Step - 2:
# Via R Studio open run_analysis.R and go to the first line of code, which contains the
# variable "WORKING_DIR". The default value is "D:\\", if you have downloaded the scripts
# into a different directory, please set the file path to "WORKING_DIR".

# Step - 3:
# You may start by sourcing the file. After finish processing it, you will find the
# "tidy.txt" in the same working directory

############# How the script works? ############# 
# The run_analysis.R script contains 5 sections and a prerequisite.
#
# On prerequisite, it will define the working directory and download plus unzip all the
# related files to your working directory. The main purpose of prerequisite is to 
# get the raw data ready for data cleaning process.

# On the first section, there are 3 sets of data need to be merged into one, they are 
# Subject dataset, Activity dataset and Features dataset. Therefore the main objective is 
# to merge these 3 datasets into one dataset.

# On the second section, the objective is to extract only the measurements on the mean 
# and standard deviation for each measurement. Therefore the features variables need
# to be filtered to only consists mean and standard deviation.

# On the third section, the Activity data is represented by numeric values. The objective
# on this section is to use descriptive activity names to name the activities in the data
# set. These descriptive names are stored in a file named "activity_labels.txt" 

# On the fourth section, the variable names will be labeled with descriptive names. 

# On the fifth section, independent tidy dataset will be created with the average of each
# variable for each activity and each subject. The features data will be grouped by 
# each activity of each subject.

###-----------END-----------###