---
title: "Getting and Cleaning Data Project Cookbook"
output: html_document
---

##Overview

#### The purpose of this file describing the variables, data, and any transformations or work performed to clean up the data. The full description of the data and associated variables can be found here: `http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones`


## Step 1 - Import Data
#
#
#### * The data is unzipped into the working directory and written into R using the `read.table` command.

Sample code: `tef_x <- read.table("C:\\ProgSQ\\R\\CourseraDataCleaning\\CleaningDataAssignment\\X_test.txt")`

#### * Data is then merged into one data set.
#
#
Code: 
`test_set <- cbind(tef_x, tef_y)`
`test_set <- cbind(test_set, sub_test)`

`train_set <- cbind(trf_x, trf_y)`
`train_set <- cbind(train_set, sub_train)`

`combined_data <- rbind(test_set, train_set)`
#
#


## Step 2 - Manipulate and Transform Data

#### * We then bring in the column labels, attaching subject and activity id.


#
#


Code: 
`column_labs <- rbind(feat_f, c(999, "Subj"))`
`column_labs <- rbind(column_labs, c(999, "ActId"))`
#
#


#### * The data is then subsetted with only four fields: Mean, Std, Subject, Activity ID.


#
#


Code:`short_combined_data <- combined_data[, grepl("[Mm]ean|[Ss]td|Subj|ActId", names(combined_data))]`


#
#


#### * The descriptive activity labels are attached to the combined data set.


#
#


Code: `short_combined_data2 <- merge(short_combined_data, act_labs, by.x = "ActId", by.y = "ActId")`


#
#


## Step 3 - Tidy and write data to tidy.txt.


#
#


#### * Subject field was factorized from integer format here


#
#


Code: `short_combined_data2$Subj <- as.factor(short_combined_data2$Subj)`


#
#


#### * Using aggregate, the data is grouped by Subject and Activity


#
#


Code: `tidy_data = aggregate(short_combined_data2, by=list(Subject = short_combined_data2$Subj, Activity = short_combined_data2$Act), mean)`


#
#


#### * Data is written to tidy.txt.


#
#


Code: `write.table(tidy_data, file = "tidy.txt", row.names = FALSE)`



