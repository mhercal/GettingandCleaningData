
library(dplyr)

##Read raw data and create one dataset for test and another for training.
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("ActivityId", "Activity"))
features<-read.table("./UCI HAR Dataset/features.txt", colClasses = c("character"))

x_test<-read.table("./UCI HAR Dataset/test/x_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
test_data<-cbind(subject_test, y_test, x_test)

x_train<-read.table("./UCI HAR Dataset/train/x_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
train_data<-cbind(subject_train, y_train, x_train)


##Point 1: Merges the training and the test sets to create one data set.
all_data<-rbind(test_data, train_data)
colnames(all_data)<-c("Subject", "Activity", features$V2)
all_data <- all_data[ , !duplicated(colnames(all_data))]


##Point 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
my_data<-select(all_data, Subject, Activity, contains("mean"), contains("std"), -contains("angle"), -contains("meanFreq"))

##Point 3: Uses descriptive activity names to name the activities in the data set.
my_data$Activity<-activity_labels[my_data$Activity, 2]


##Point 4: Appropriately labels the data set with descriptive variable names. 
names(my_data)<-gsub("[-()]", "", names(my_data))
names(my_data) <- gsub("^t", "Time", names(my_data))
names(my_data) <- gsub("^f", "Freq", names(my_data))
names(my_data) <- gsub("Acc", "Accelerator", names(my_data))
names(my_data) <- gsub("Gyro", "Gyroscope", names(my_data))
names(my_data) <- gsub("Mag", "Magnitude", names(my_data))
names(my_data) <- gsub("mean", 'Mean', names(my_data))
names(my_data) <- gsub("std", 'Std', names(my_data))



##Point 5: From the data set in step 4, creates a second,
#independent tidy data set with the average of each variable for each activity and each subject.
tidy_data<-group_by(my_data, Subject, Activity)%>%summarise_each(funs(mean))
write.table(tidy_data, file = "tidy_data.txt", row.name=FALSE )