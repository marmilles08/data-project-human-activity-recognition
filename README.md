# Human Activity Recognition: tidy data project

## About the project

The project consisted of writing R code that takes a subset of data from several data sets to find the grouped averages (by individuals and by activities), improving the descriptions of the variable names. The code is provided, along with its result and a CodeBook that explains which transformations were made with respect to the original source. The data sets were merged by position because they have no column in common.

## Files in this repository

`run_analysis.R` is the code, `tidy_data.txt` is the result, `CodeBook.md` is where the transformations that were made can be seen and where the handling of the data and what the script does are explained in more detail, and `README.md` explains what the whole project consists of and how to run it.

## How to run it

The `dplyr` package is needed.

## Source of the data

The data come from the "Human Activity Recognition Using Smartphones" dataset, created by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto of the Smartlab laboratory at the University of Genoa. The file used is downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Citation required by the authors:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.

The authors state that use of the dataset in publications must cite this reference, that the dataset is distributed as is, and that commercial use is prohibited.
