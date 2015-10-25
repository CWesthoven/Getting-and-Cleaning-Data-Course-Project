# Introduction

The script `run_analysis.R`performs the 5 steps described in the course project's definition.

* First, all the similar data is merged using the `rbind()` function. By similar, we address those files having the same number of columns and referring to the same entities.
* Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from `features.txt`.
* As activity data is addressed with values 1:6, we take the activity names and IDs from `activity_labels.txt` and they are substituted in the dataset.
* On the whole dataset, those columns with vague column names are corrected.
* Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called `averages_data.txt`, and uploaded to this repository.

## Variables
##### Data Type: Details
* numeric: `xTrain`, `yTrain`, `xTest`, `yTest`, `SubjectTrain` and `SubjectTest` contain the data of measurements from each of the files within the downloaded data.
* numeric:`trainingData` is a merged set of `xTrain`, `yTrain`, and `SubjectTrain` datasets to further analysis.
* numeric:`testData` is a merged set of `xTest`, `yTest`, and `SubjectTest` datasets to further analysis.
* numeric:`finalData is a merged set of `testData` and `trainingData` datasets to further analysis.
* Character: `colNames` contains the correct names for `xTest` the dataset, which are applied to the column names stored in `finalData`
* Character: A similar approach is taken with activity names through the `ActivityType` variable.
* numeric: `finalDataNoActivityType` contains the relevant averages which will be later stored in a `tidyData.txt` file.

### Create a tidy data set

From the `finalDataNoActivityType` data set is created a `tidyData` data set where numeric
variables are averaged for each activity and each subject.

The tidy data set contains 10299 observations with 81 variables divided in:

*  an activity label (__Activity__): WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
*  an identifier of the subject who carried out the experiment (__Subject__):
   1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30
*  a 79-feature vector with time and frequency domain signal variables (__Numeric__)
