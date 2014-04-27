## Getting and Cleaning Data Project

This is the exercise for 'Getting and Cleaning Data' Course

To run this project you will need this data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

* Unpack the data as to have 'UCI HAR Dataset' directory and its subdirectories inside your working directory.
* Copy run_analysis.R to your working directory.
* Install the 'plyr' package if you don't have it.

The run_analysis.R will 
* Merge the training and the test sets to create one data set.
* Extract only the measurements on the mean and standard deviation for each measurement.
* Generate a tidy data set with the average of each variable for each activity and each subject.
* Export this final tidy data to a 'tidyData.csv' in your working directory.