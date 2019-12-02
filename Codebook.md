1. Downloading data: downloads data from internet, then unzips the file

2. assigning the data frames:
a. features: Shows the variables used on the feature vector. 
b. activities: Links the class labels with their activity name.
c. subject_test: contains test data from 9 volunteers 
d. x_test: contains features test data
e. y_test: contains test data of activity code labels
f. subject_train: contains test data from 21 volunteers
g. x_train: contains recorded features train dat
h. x_train: contains train data of activity code labels

3. X is created by merging x_train and x_test using rbind()
   Y is created by merging y_train and y_test using rbind()
   subject is created by merging subject_train and subject_test using rbind()
   master is created by merging X, Y, subject using cbind()
  
4. mstd is created by subsetting the subject and code columns, and then taking all columns that include a mean or standard deviation

5. Using the activities data frame, we replace the numbers in the code column. 

6. Used gsub to replace abbreviations with full names. Also fixed certain parts using gsub()

7. tidymean is created by grouping the subject and activity data, then finding the mean of each column. 
