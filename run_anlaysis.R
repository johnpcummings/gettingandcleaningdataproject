######################################################################################################
## preparation
######################################################################################################
# download zip files to working directory
# set working directory in RStudio:
#   Session/Set Working Directory/Choose Working Directory/ "select directory with files"
# load library
library("data.table")
######################################################################################################
## stage one: download all files and merge the training and the test sets to create one data set
######################################################################################################
# download all files to RStudio
xtestdata <- read.table("X_test.txt")
xtraindata <- read.table("X_train.txt")
ytestlabels <- read.table("y_test.txt", col.names="labels")
ytrainlabels <- read.table("y_train.txt", col.names="labels")
testsubjects <- read.table("subject_test.txt", col.names="subjects")
trainsubjects <- read.table("subject_train.txt", col.names="subjects")
# extract features
features <- read.table("features.txt", strip.white=TRUE, stringsAsFactors=FALSE)
# optain 6 activity labels names from activities_label file 
activitylabels <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
# use rbind and cbind to combine data with format: subjects, labels, test and train data
mergedata <- rbind(cbind(testsubjects, ytestlabels, xtestdata),
                   cbind(trainsubjects, ytrainlabels, xtraindata))
######################################################################################################
## stage two: extract only the measurements on the mean and standard deviation for each measurement 
## note on stage two: not included are meanfreq columns as it is not a mean or standard deviation
######################################################################################################
# extract mean and standard deviation features
meanstdfeatures <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]
# select only the means and standard deviations from mergeddata
# increment by 2 to allow for subjects and labels in the beginning
meanstddata <- mergedata[, c(1, 2, meanstdfeatures$V1+2)]
######################################################################################################
## stage three: use descriptive activity names to name the activities in the data set
######################################################################################################
# replace labels in data with label names
meanstddata$labels <- activitylabels[meanstddata$labels, 2]
######################################################################################################
## stage four: qppropriately label the data set with descriptive variable names
######################################################################################################
# create a list of the column names and feature names
rptcolumnnames <- c("subject", "label", meanstdfeatures$V2)
# tidy column names and features names with lower case alpha characters
# by removing every non-alphabetic character and converting to lowercase
rptcolumnnames <- tolower(gsub("[^[:alpha:]]", "", rptcolumnnames))
# use above tidy column names to update colnames of meanstddata information
colnames(meanstddata) <- rptcolumnnames
######################################################################################################
## stage five: creates a second tidy data set from stage 4 (meanstddata) with the average 
## of each variable for each activity and each subject from meanstddata subject and labels.
######################################################################################################
# find the mean for each combination of subject and label
aggregatedata <- aggregate(meanstddata[, 3:ncol(meanstddata)],
                           by=list(subject = meanstddata$subject,label = meanstddata$label),mean)
######################################################################################################
## final: write file tidydataset.txt for coursera class
######################################################################################################
# write tidydateset.txt to file for coursera class
write.table(format(aggregatedata, scientific=T),"tidydataset.txt",row.names=F, col.names=F, quote=2)
