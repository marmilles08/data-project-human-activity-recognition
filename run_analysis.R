# run_analysis.R
# Cleans and summarises the UCI HAR Dataset (see README.md and CodeBook.md)

library(dplyr)

# Download and unzip the data (only if needed)
if (!file.exists("UCI HAR Dataset")) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, destfile = "UCI_HAR_Dataset.zip", mode = "wb")
  unzip("UCI_HAR_Dataset.zip")
}

# File paths
data_dir <- "UCI HAR Dataset"
file_paths <- c(file.path(data_dir, "train", c("X_train.txt", "y_train.txt", "subject_train.txt")),
                file.path(data_dir, "test",  c("X_test.txt",  "y_test.txt",  "subject_test.txt")),
                file.path(data_dir, c("features.txt", "activity_labels.txt")))

# Read the files
files <- lapply(file_paths, read.table)
names(files) <- c("xTrain", "yTrain", "subjectTrain",
                  "xTest",  "yTest",  "subjectTest",
                  "features", "activityLabels")

# Step 1: merge the training and test sets
train <- cbind(files$subjectTrain, files$yTrain, files$xTrain)
test  <- cbind(files$subjectTest,  files$yTest,  files$xTest)
data_all <- rbind(train, test)   # 10299 rows, 563 columns

# Step 2: name the columns and keep only the mean and standard deviation measurements
names(data_all) <- c("subject", "activity", files$features$V2)

keep_cols <- grepl("mean\\(\\)|std\\(\\)", names(data_all))
keep_cols[1:2] <- TRUE   # keep subject and activity
data_sel <- data_all[, keep_cols]   # 10299 rows, 68 columns

# Step 3: use descriptive activity names
data_sel$activity <- factor(data_sel$activity,
                            levels = files$activityLabels$V1,
                            labels = files$activityLabels$V2)

# Step 4: label the variables with descriptive names
patterns     <- c("BodyBody", "^t",   "^f",        "Acc",           "Gyro",      "Mag",       "mean\\(\\)", "std\\(\\)",          "-")
replacements <- c("Body",     "Time", "Frequency", "Accelerometer", "Gyroscope", "Magnitude", "Mean",       "StandardDeviation", "")

var_names <- names(data_sel)
for (i in seq_along(patterns)) {
  var_names <- gsub(patterns[i], replacements[i], var_names)
}
names(data_sel) <- var_names

# Step 5: average of each variable for each activity and each subject
grouped    <- group_by(data_sel, subject, activity)
tidy_data  <- summarise(grouped, across(everything(), mean), .groups = "drop")

write.table(tidy_data, "tidy_data.txt", row.names = FALSE)