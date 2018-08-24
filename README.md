# Getting-and-Cleaning-Data-Course-Project-
Submission for Course Project for Getting-and-Cleaning-Data course in Coursera
## Part 0 (Load packages, files and tyde names)
 * Load packages to be used during the analysis.
 * Read Train and Test Data Sets and Subjects and Activities files
(We assume there exists a directory "UCI HAR Dataset" in the working directory whith the corresponding structure and 
files in it).
 * Tyde column names. (Eliminates special characters to simplify column names and avoid repeated names)
 * Then apply corrected names to X_test and X_train columns
## Part 1 (Merges the training and the test sets to create one data set.)
 * Append to each X file, the corresponding columns from "y" file and "subject" file, assuming the row order is the same in all 3 files.
 * Merge these new two bases in one big file with all the observations from train and test subjects.

## Part 2 (Extracts only the measurements on the mean and standard deviation for each measurement.)
 * Generate names vector with means and standard deviations to be included.
 * Generate names vector with means to be excluded (within angle() variables that we consider should not be included with the rest of measurements).
 * Select columns corresponding to correct means and standard deviations.

## Part 3 (Uses descriptive activity names to name the activities in the data set)
 * Replace the values from 1 to 6 in column "labels" with the descriptive activity names from file "activity_labels.txt" applying a procedure sugested in https://drive.google.com/file/d/0B1r70tGT37UxYzhNQWdXS19CN1U/view .


## Part 4 (Appropriately labels the data set with descriptive variable names)
 * This was done in 2nd part when creating the database.

## Part 5 (From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject)
 * Create a new summary database which rows includes the data means for every column calculated for each individual and for each activity.
 * Finally, save this last database as a tidyData.txt file in our working directory.
