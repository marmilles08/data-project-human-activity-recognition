# Human Activity Recognition: tidy data project

## About the project

This project takes data from the UCI HAR Dataset (accelerometer and gyroscope measurements from a smartphone, recorded for 30 volunteers who performed 6 activities) and, with an R script, obtains the average of the mean and standard deviation measurements for each subject and each activity. The variable names are also improved so that they are more descriptive. The original data files were merged by position, because they do not share a common column.

## Files in this repository

- `run_analysis.R`: script that downloads the data, transforms it and produces the result.
- `tidy_data.txt`: tidy data set with the averages by subject and activity (180 rows and 68 columns).
- `CodeBook.md`: describes the data, the variables and the transformations made with respect to the original source.

## How to run the script

1. Have R installed, along with the `dplyr` package. It is installed once with `install.packages("dplyr")`.
2. Download `run_analysis.R` into a folder and set that folder as the working directory in R.
3. Run `source("run_analysis.R")`. The first time, the script downloads and unzips the original data (an internet connection is required).
4. When it finishes, `tidy_data.txt` is created in the same folder. It can be read with `read.table("tidy_data.txt", header = TRUE)`.

## Source of the data

The data come from the "Human Activity Recognition Using Smartphones" dataset, created by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto of the Smartlab laboratory at the University of Genoa. The file used is downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Citation required by the authors:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.

The authors state that use of the dataset in publications must cite this reference, that the dataset is distributed as is, and that commercial use is prohibited.
