library(dplyr)

##downloading data
filename <- "Coursera_DS3_Final.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

##assigning data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#Merging training and test sets into one set of data
X<- rbind(x_test, x_train)
Y<- rbind(y_test, y_train)
subject<- rbind(subject_train, subject_test)
master<- cbind(X, Y, subject)

#Extracts only the measurements on the mean and standard deviation for each measurement
mstd<-select(master, subject, code, contains("mean"), contains("std"))

#Use descriptive activity names to name activities in the data set
mstd$code <- activities[mstd$code, 2]

#Appropriately labels the data set with descriptive variable names.
names(mstd)[2]="activity"
names(mstd)<- gsub("acc.", " Acceleration ", names(mstd), ignore.case =TRUE)
names(mstd)<- gsub("^t", "Time ", names(mstd))
names(mstd)<- gsub("^f", "Frequency ", names(mstd))
names(mstd)<- gsub("gyro", " Gyroscope ", names(mstd), ignore.case =TRUE)
names(mstd)<- gsub("Mag", "Magnitude", names(mstd))
names(mstd)<- gsub("Jerk", " Jerk ", names(mstd))
names(mstd)<- gsub("mean...", " Mean ", names(mstd))
names(mstd)<- gsub("erk", " Jerk ", names(mstd))
names(mstd)<- gsub("ag", "Magnitude", names(mstd))
names(mstd)<- gsub(".std", "STD", names(mstd))
names(mstd)<- gsub("MM", "M", names(mstd))
names(mstd)<- gsub("J J", "J", names(mstd))
names(mstd)<- gsub("q...", " ", names(mstd))
names(mstd)<- gsub(".gravity", " Gravity ", names(mstd))

#create a second, independent tidy data set with the average of each variable for each activity and each subject.
tidymeans<- mstd %>%
  group_by(subject, activity)%>%
  summarise_all(funs(mean))