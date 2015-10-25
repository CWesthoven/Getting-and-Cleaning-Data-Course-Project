## Coursera Getting and Cleaning Data Course Project
## CWesthoven

# run_Analysis.r File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


# Clean up workspace
rm(list=ls())

# 1. Merge the training and the test sets to create one data set.

# Read Train data from files
Features <- read.table('./UCI HAR Dataset/features.txt',header=FALSE);
ActivityType <- read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE);
SubjectTrain <- read.table('./UCI HAR Dataset/train/subject_train.txt',header=FALSE);
xTrain <- read.table('./UCI HAR Dataset/train/x_train.txt',header=FALSE);
yTrain <- read.table('./UCI HAR Dataset/train/y_train.txt',header=FALSE);

# Add Column Names
colnames(ActivityType) <- c('activityId','activityType');
colnames(SubjectTrain) <- "subjectId";
colnames(xTrain) <- Features[,2]; 
colnames(yTrain) <- "activityId";

# Merge Training data from yTrain,SubjectTrain,xTrain
trainingData <- cbind(yTrain,SubjectTrain,xTrain);

# Read in the test data
SubjectTest <- read.table('./UCI HAR Dataset/test/subject_test.txt',header=FALSE);
xTest <- read.table('./UCI HAR Dataset/test/x_test.txt',header=FALSE);
yTest <- read.table('./UCI HAR Dataset/test/y_test.txt',header=FALSE);

# Add column names to the test data
colnames(SubjectTest) <- "subjectId";
colnames(xTest) <-  Features[,2]; 
colnames(yTest) <- "activityId";


# Merge test data from xTest, yTest and subjectTest
testData <- cbind(yTest,SubjectTest,xTest);


# Merge training and test data
finalData <- rbind(trainingData,testData);

# Create a vector for the column names from the finalData, 
# used to select the columns for mean and stddev later
colNames <- colnames(finalData); 

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# Create a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for else
logicalVector <- (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

# Subset finalData table to keep true values from logicalVector
finalData <- finalData[logicalVector==TRUE];

# 3. Use descriptive activity names to name the activities in the data set

# Merge the ActivityType and finalData in order to include the descriptive activity names
finalData <- merge(ActivityType,finalData,by='activityId',all.x=TRUE);

# Update colNames so it contains all column names after the merge
colNames <- colnames(finalData); 

# 4. Appropriately label the data set with descriptive activity names. 

# Cleaning up the variable names
  colNames <- gsub("^t", "time", colNames);
  colNames <- gsub("^f", "frequency", colNames);
  colNames <- gsub("Acc", "Accelerometer", colNames);
  colNames <- gsub("Gyro", "Gyroscope", colNames);
  colNames <- gsub("Mag", "Magnitude", colNames);
  colNames <- gsub("BodyBody", "Body", colNames);
  colNames <- gsub("\\()","",colNames);
  colNames <- gsub("-std$","-StdDev",colNames);

# Reassigning the new descriptive column names to the finalData set
colnames(finalData) <- colNames;

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Create finalDataNoActivityType without the activityType column
finalDataNoActivityType <- finalData[,names(finalData) != 'activityType'];

# Summarize to show aggregate mean values only
tidyData <- aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean);

# Merging the tidyData with activityType to include descriptive acitvity names
tidyData <- merge(tidyData,ActivityType,by='activityId',all.x=TRUE);

# Write the tidyData.txt file
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');
