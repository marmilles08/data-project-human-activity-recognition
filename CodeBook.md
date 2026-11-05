# Code book

## Source data

The data come from the "Human Activity Recognition Using Smartphones" dataset (folder `UCI HAR Dataset`), created by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto of the Smartlab laboratory at the University of Genoa. The file used is downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Citation required by the authors:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.

The authors state that use of the dataset in publications must cite this reference, that the dataset is distributed as is, and that commercial use is prohibited.

## Data set description

The `tidy_data` file is the version with only the information related to the mean and standard deviation, already averaged and divided by individual and by activity, where the results of the sample of the 30 individuals are given, each one performing the 6 activities. That is, there are 180 rows (30x6) and 68 columns (individual, activity, plus the 66 mean and standard deviation variables).

## Variables

### Identifiers

`subject`: takes the data of the 30 individuals, with a value from 1 to 30. In the original data it comes in a separate file, in the same row order as the measurements.

`activity`: in the original data it takes a value from 1 to 6, which is then transformed using the names of the activities. In `tidy_data.txt` it already appears with the name.

### Measurements

There are 66 measurements, whose names are more specific than in the original. The name itself says whether it refers to a mean or a standard deviation, and what type of measurement it is. More detail on how they are built can be found in `features_info.txt` and `README.txt` of the original dataset.

## Transformations

The files are read. Since there is no common column, the columns are pasted by position (`cbind`) and then train and test are stacked with `rbind`. In this step the individuals and the activities are already joined. From `features` only column 2 is used, which serves to name the columns. The columns with mean and standard deviation are kept (plus columns 1 and 2, which are marked by hand). The activity numbers are changed to their names with `activity_labels`. The variables are named and `gsub` is used to make the names clearer. Finally, the average is calculated by individual and by activity, and it is saved in `tidy_data.txt`.
