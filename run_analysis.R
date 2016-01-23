
# Read all source files.

tef_x <- read.table("C:\\ProgSQ\\R\\CourseraDataCleaning\\CleaningDataAssignment\\X_test.txt")
trf_x <- read.table("C:\\ProgSQ\\R\\CourseraDataCleaning\\CleaningDataAssignment\\X_train.txt")
tef_y <- read.table("C:\\ProgSQ\\R\\CourseraDataCleaning\\CleaningDataAssignment\\y_test.txt")
trf_y <- read.table("C:\\ProgSQ\\R\\CourseraDataCleaning\\CleaningDataAssignment\\y_train.txt")
sub_test <- read.table("C:\\ProgSQ\\R\\CourseraDataCleaning\\CleaningDataAssignment\\subject_test.txt")
sub_train <- read.table("C:\\ProgSQ\\R\\CourseraDataCleaning\\CleaningDataAssignment\\subject_train.txt")
feat_f <- read.table("C:\\ProgSQ\\R\\CourseraDataCleaning\\CleaningDataAssignment\\features.txt", colClasses = "character")
act_labs<- read.table("C:\\ProgSQ\\R\\CourseraDataCleaning\\CleaningDataAssignment\\activity_labels.txt", col.names = c("ActId", "Act"))

# Combine the datasets below:
# * Bind the test set, labels, and subject id using cbind
# * Repeat for the training set
# * Bind test and training sets together using rbind

test_set <- cbind(tef_x, tef_y)
test_set <- cbind(test_set, sub_test)

train_set <- cbind(trf_x, trf_y)
train_set <- cbind(train_set, sub_train)

combined_data <- rbind(test_set, train_set)

# Bring in the labels.  "999" is just a filler.

column_labs <- rbind(feat_f, c(999, "Subj"))
column_labs <- rbind(column_labs, c(999, "ActId"))

# Attaching labels using data from 2nd column of column_labs.

names(combined_data) <- column_labs[,2]

# Subset combined_data by the fields that we are interested in: the mean, standard deviation, Subject, and ActId

short_combined_data <- combined_data[, grepl("[Mm]ean|[Ss]td|Subj|ActId", names(combined_data))]

# Bring in descriptive activity labels by inner joining (merge) short_combined_data with act_labs using common ActId.

library(reshape2)
short_combined_data2 <- merge(short_combined_data, act_labs, by.x = "ActId", by.y = "ActId")



# Tidy data

## Running str, we see that we need to factorize Subj for the next analysis.  Act is already a factor.
short_combined_data2$Subj <- as.factor(short_combined_data2$Subj)

# Create a second, independent tidy data set with the average of each variable for each activity and each subject

tidy_data = aggregate(short_combined_data2, 
                      by=list(Subject = short_combined_data2$Subj, Activity = short_combined_data2$Act), mean)

write.table(tidy_data, file = "tidy.txt", row.names = FALSE)
