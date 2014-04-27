### Codebook for the Getting and Cleaning Data Project

The run_analysis code will read the 'Human Activity Recognition Using Smartphones Data Set' avaliable at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

-It merges both training and test sets (/train/X_train.txt and /test/X_test.txt)
-It includes the subjects who performed the activities (/train/subject_train.txt and /test/subject_test.txt)
-It does NOT include the Inertial Signals
-It properly labels all the data
-It subsets the data using only subjects and measurement that are mean values or standard deviation values
-It does NOT use in the data subset any of the 'angle' values, although they are calculated using mean values.
-It creates a tidy data set with the average of each of the variables on the data subset for each activity and each subject.
-It exports the final tidy data set to 'tidyData.csv'