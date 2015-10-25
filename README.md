# Getting-and-Cleaning-Data-Course-Project
==========================================

This is the course project for the Getting and Cleaning Data course from Coursera.
### Contents
This repository contains the R script for taking the data from the [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and combining test and training data to create aggregates of each activity and subject.

`CodeBook.md` is the discription of the variables, data, and any work that was conducted in the process of cleaning the data.

`run_analysis.R` contains all the code to perform the analyses described in the requisite 5 steps. 

The output of the 5th step is called `tidyData.txt`, and uploaded in the course project's form.

### Project Summary

The following is a summary description of the project instructions

You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set. 

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set.

4. Appropriately labels the data set with descriptive activity names.

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Notes
The data found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) should be saved within the working directory before running the R script.
