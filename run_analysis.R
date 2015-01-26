setwd("~/r_work/clean_assignment1/UCI HAR Dataset")

# Get common data
features <- read.csv("./features.txt", header=FALSE, sep=" ", col.names=c("Id", "Description"))
activities <- read.csv("./activity_labels.txt", header=FALSE, sep=" ", col.names=c("Id", "Description"))

# Helper function
findActivityDescription <- function(x) { activities[activities$Id == x, "Description"]}

# Prepare train data
trainSubjects <- read.csv("./train/subject_train.txt", header=FALSE, col.names=c("Id"))
trainSubjectActivities <- read.csv("./train/y_train.txt", header=FALSE, col.names=c("ActivityId"))

# Add description to train subjects activities
trainSubjectActivityDescriptions <- sapply(trainSubjectActivities$ActivityId, findActivityDescription)

trainData <- read.fwf("./train/X_train.txt", widths=rep.int(16,561), col.names=features$Description)

# Add subjects to trainData
trainData$Subject <- trainSubjects$Id

# Add subject activities to trainData
trainData$ActivityId <- trainSubjectActivities$ActivityId

# Add subject activity descriptions  to trainData
trainData$ActivityDescription <- trainSubjectActivityDescriptions

# Add source to trainData
trainData$Source <- "Train"
  
# Prepare test data
testSubjects <- read.csv("./test/subject_test.txt", header=FALSE, col.names=c("Id"))
testSubjectActivities <- read.csv("./test/y_test.txt", header=FALSE, col.names=c("ActivityId"))

# Add description to test subjects activities
testSubjectActivityDescriptions <- sapply(testSubjectActivities$ActivityId, findActivityDescription)

testData <- read.fwf("./test/X_test.txt", widths=rep.int(16,561), col.names=features$Description)

# Add subjects to testData
testData$Subject <- testSubjects$Id

# Add subject activities to testData
testData$ActivityId <- testSubjectActivities$ActivityId

# Add subject activity descriptions  to testData
testData$ActivityDescription <- testSubjectActivityDescriptions

# Add source to testData
testData$Source <- "Test"

# Combine 2 data sets
combinedData <- rbind(trainData, testData)

# Extract standard deviation, and mean columns
stdMeanData <- combinedData[,grep("std()|mean()|Subject|ActivityId|ActivityDescription", names(trainData))]


