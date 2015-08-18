#Course project code book

##Introduction
The script `run_analysis.R` reads the data contained in the `UCI HAR Dataset` folder(*), merges the different datasets into one, extracts only the measurements on the mean and standard deviation for each measurement, ses descriptive activity names to name the activities in the data set, appropriately labels the data set with descriptive variable names and creates a second, independent tidy data set with the average of each variable for each activity and each subject.

(*)The data should be stored in the user's working directory without any alterations.
   Download link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
   
##Variables
`activity_labels`, `features`, `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.

`test_data` and `train_data` combine the test and train sets by columns.

`all_data` contains the previous data sets merged by rows and the appropriate column names ("Subject", "Activity" and all the measurements stored in features), without duplicates. 

`my_data` extracts only the mean and standard deviation variables for the thirty three signals measured using some options from the dplyr library. This is a processed data set that includes the six activity names contained in `activity_labels` instead of their numerical code, and descriptive column names changed with `gsub`.

`tidy_data` is a second, independent tidy data set with the average of each variable for each activity and each subject.
It has 180 rows (30 subjects * 6 activities) and 68 columns, one for the subjects, one for the activity and 66 for the mean and standard deviation calculated on each of the 33 signals measured on the data.


  
