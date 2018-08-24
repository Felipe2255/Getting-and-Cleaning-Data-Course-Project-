#0)

#load packages to be used during the analysis
library(readr)
library(dplyr)
library(tidyr)

#Reading Train and Test Data Sets and Subjects and Activities files
#(We assume there exists a directory "UCI HAR Dataset" in the working directory
#       whith the corresponding files in it).

X_train <- read_table2("UCI HAR Dataset/train/X_train.txt", col_names = FALSE)
subject_train <- read_csv("UCI HAR Dataset/train/subject_train.txt", col_names = "subject")
y_train <- read_csv("UCI HAR Dataset/train/y_train.txt", col_names = "labels")
X_test <- read_table2("UCI HAR Dataset/test/X_test.txt", col_names = FALSE)
subject_test <- read_csv("UCI HAR Dataset/test/subject_test.txt", col_names = "subject")
y_test <- read_csv("UCI HAR Dataset/test/y_test.txt", col_names = "labels")
features <- read_table2("UCI HAR Dataset/features.txt", col_names = FALSE)

#Create column names vector from "features" table
names <- as.vector(features[['X2']])

#Tyding column names. (Eliminates special characters to simplify column names and
#       avoid repeated names.

names <- gsub("\\()", "", names); names <- gsub("\\(", "_", names); names <- gsub("\\)", "", names)

for(i in 1:3){
        for(j in 1:length(names)){
                if(names[j] %in% names[j+1:length(names)]){
                        names[j] <- paste(names[j], as.character(i), sep="_")
                }
        }
}

gsub("_1_2", "_2", names) -> names

#applying corrected names to X_test and X_train columns

colnames(X_test) <- names
colnames(X_train) <- names


#1)
#Merges the training and the test sets to create one data set.

#First append to each X file, the corresponding columns from "y" file and "subject" file
#Assuming the row order is the same in all 3 files.

testBase <- cbind(X_test, y_test, subject_test)
trainBase <-cbind(X_train, y_train, subject_train)

#Merge these new two bases in one big file with all the observations from train 
#       and test subjects.

wholebase <- rbind(testBase, trainBase)

#2)
#Extracts only the measurements on the mean and standard deviation for each measurement.

#Generate names vector with means and standard deviations to be included:

truenames <- names[grepl("mean|std", names)]

#Generate names vector with means to be excluded (within angle() variables that 
#       we consider should not be included with the rest of measurements).

foonames <- names[grepl("meanF", names)]

#Select columns corresponding to correct means and standard deviations.

newbase <- select(wholebase, truenames, -foonames, "labels", "subject")

#3)
#Use descriptive activity names to name the activities in the data set

#Create activity names vector from "activities.txt file"

activitynames <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

#replace numbers for these names in respective column

newbase$labels <- activitynames[newbase$labels]

#4)
#Appropriately labels the data set with descriptive variable names.
#This was done in 2nd point when creating the database.

#5)
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

groupedbase <- group_by(newbase, labels, subject)

groupedmeans <- summarise_all(groupedbase, mean)

View(groupedmeans)
dim(groupedmeans)

#save this last database as a tidyData.txt file
write.csv(groupedmeans, "tidyData.txt", row.names = FALSE)
