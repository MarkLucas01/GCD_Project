# GCD_Project
Getting and Cleaning Data Course Project Repo

# How this script works…
First, from your working directory, you’ll need to download and extract the following data sets:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

With the data in your working directory, you’ll be able to use run_analysis.R as follows.
- Run R in the respective working directory
- Load the script via this command -> source (“run_analysis.R”); this action will (from the assignment)…
—— (1) Merges the training and the test sets to create one data set.
—— (2) Extracts only the measurements on the mean and standard deviation for each measurement. 
—— (3) Uses descriptive activity names to name the activities in the data set
—— (4) Appropriately labels the data set with descriptive variable names. 
—— (5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- A file will be created in your working directory, titled “safTable.txt”
- Rename “safTable.txt” to “safTable.csv”
- Open safTable.csv in a worksheet such as MS Excel to view the results