---
title: "Codebook.md"
author: "JPCummings"
date: "Saturday, January 24, 2015"
---

Setup, a JohnsHopkins/Coursera class project to download the Human Activity Recognition Using Smartphones Dataset and provide the average of each mean and standard deviation feature for each combination of data subjects and data label.

Raw data provided by the URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
'features_info.txt': Shows information about the variables used on the feature vector.
'features.txt': List of all features.
'activity_labels.txt': Links the class labels with their activity name.
'train/X_train.txt': Training set.
'train/y_train.txt': Training labels.
'test/X_test.txt': Test set.
'test/y_test.txt': Test labels.
The project entailed combining the data from the test and train files with their respective subject and label information in on data set.  This data set was then reduced to only include mean and standard deviation data and the label column was transformed to the more meaningful (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) label.  The descriptive column names obtained from the features file were transformed to only include lower case alpha characters.  The file was created to include the average of each mean and standard deviation for each feature with respect to each combination of subject and label.  The final file names tidydataset.txt contains 180 observations of 68 variables.  Only features that included mean() or std() were retained and not the meanFreq() features as they are not a mean or std feature in my opinion.
Codebook: The test subjects (2947 observations of 1 variable), the test labels (2947 observations of 1 variable), and the test data (2947 observations of 561 variables) along with the train subjects (7352 observations of 1 variable), the train labels (7352observations of 1 variable), and the train data (7352observations of 561 variables) were merged with rbind and cbind into one large data set (mergedata) that contained 10299 observations of 563 variables. The mergedata file was then reduced to only include features that included a mean() or std() and column names were added with respective features names to a new data set named meanstddata that contained 10299 observations of 66 variables.  The numeric value in the labels column was replaced with respective descriptive (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) label with the corresponding numeric value and the remained at 10299 observations of 66 variables.  The column 