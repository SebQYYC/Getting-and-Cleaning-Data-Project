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

## Complete list of features from features_info.txt

Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

`tBodyAcc-XYZ`
`tGravityAcc-XYZ`
`tBodyAccJerk-XYZ`
`tBodyGyro-XYZ`
`tBodyGyroJerk-XYZ`
`tBodyAccMag`
`tGravityAccMag`
`tBodyAccJerkMag`
`tBodyGyroMag`
`tBodyGyroJerkMag`
`fBodyAcc-XYZ`
`fBodyAccJerk-XYZ`
`fBodyGyro-XYZ`
`fBodyAccMag`
`fBodyAccJerkMag`
`fBodyGyroMag`
`fBodyGyroJerkMag`

The set of variables that were estimated from these signals are: 

`mean(): Mean value`
`std(): Standard deviation`
`mad(): Median absolute deviation `
`max(): Largest value in array`
`min(): Smallest value in array`
`sma(): Signal magnitude area`
`energy(): Energy measure. Sum of the squares divided by the number of values.` 
`iqr(): Interquartile range `
`entropy(): Signal entropy`
`arCoeff(): Autorregresion coefficients with Burg order equal to 4`
`correlation(): correlation coefficient between two signals`
`maxInds(): index of the frequency component with largest magnitude`
`meanFreq(): Weighted average of the frequency components to obtain a mean frequency`
`skewness(): skewness of the frequency domain signal `
`kurtosis(): kurtosis of the frequency domain signal `
`bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.`
`angle(): Angle between to vectors.`

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

`gravityMean`
`tBodyAccMean`
`tBodyAccJerkMean`
`tBodyGyroMean`
`tBodyGyroJerkMean`

