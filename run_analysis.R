library(plyr);

# load text files into data frames
featuresHeader  <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
featuresTestDF  <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
featuresTrainDF <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
subjectTestDF   <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
subjectTrainDF  <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityHeader  <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
activityTestDF  <- read.table("./UCI HAR Dataset/test/Y_test.txt", header = FALSE)
activityTrainDF <- read.table("./UCI HAR Dataset/train/Y_train.txt", header = FALSE)

# group the records (aka rows) with rbind() for the features / subject / activitiy data sets
featuresRowBoundDF <- rbind(featuresTestDF, featuresTrainDF)
subjectRowBoundDF  <- rbind(subjectTestDF, subjectTrainDF)
activityRowBoundDF <- rbind(activityTestDF, activityTrainDF)

### PROJECT STEP 2/5 - "Extracts only the measurements on the mean and standard deviation for each measurement"
featuresMeanStd     <- sort(rbind(grep("mean\\(\\)",featuresHeader[,2]),grep("std\\(\\)",featuresHeader[,2])))
featuresExtractedDF <- featuresRowBoundDF[,featuresMeanStd]

### PROJECT STEP 3/5 - Uses descriptive activity names to name the activities in the data set
activityRowBoundDF$activity <- apply(activityRowBoundDF, 1, function(row) activityHeader[row[1],2])

### PROJECT STEP 1/5 - "Merge the training & test sets to create one data set"
# one data set = safTable
subjectActivityCols <- cbind(subjectRowBoundDF, activityRowBoundDF)  # bind subject & activity as 1st 3 cols
safTable            <- cbind(subjectActivityCols, featuresExtractedDF)

# safTable<-safTable[order(safTable$Subject,safTable$Activity),]  # to see data set in order
# dim(safTable) = 10299 rows & 69 columns

### PROJECT STEP 4/5 - "Appropriately labels the data set with descriptive variable names"
# 1st two cols are Subject & Activity, then we'll grab the respective column names from features.txt
featuresColumnNames <- sub("-","",featuresHeader[featuresMeanStd,2]) # need to substitute this char to get the appropriate cols
colnames(safTable) <- c("Subject","Activity","Activity_Desc",featuresColumnNames)

### PROJECT STEP 5/5 - "From the data set in step 4, creates a second, independent tidy data set with 
###                     the average of each variable for each activity and each subject"
# second data set = safTable_2
safTable_2 <- aggregate(. ~ Subject+Activity+Activity_Desc, data=safTable, FUN=mean)

# dim(safTable_2) = 180 rows & 69 columns (the reduced numbers of rows is due to the averages)

# write.table() using row.name=FALSE 
write.table(safTable_2,file="safTable.txt",sep=",",row.names=FALSE)  # utilized the comma to open as a csv file
