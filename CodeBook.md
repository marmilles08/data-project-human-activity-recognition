# Code book

## Source data

The data come from the "Human Activity Recognition Using Smartphones" dataset (folder `UCI HAR Dataset`), created by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto of the Smartlab laboratory at the University of Genoa. The file used is downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The experiment was carried out with 30 volunteers aged 19 to 48. Each of them performed six activities wearing a Samsung Galaxy S II smartphone on the waist, whose accelerometer and gyroscope recorded 3-axial linear acceleration and 3-axial angular velocity at 50 Hz. The data were split into two sets: 70% of the volunteers for training (train) and 30% for testing (test).

Citation required by the authors:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.

The authors state that use of the dataset in publications must cite this reference, that the dataset is distributed as is, and that commercial use is prohibited.

## Data set description

`tidy_data.txt` contains the average of the mean and standard deviation measurements of the UCI HAR Dataset, by subject and by activity. The data come from 30 volunteers, each of whom performed the 6 activities (walking, walking upstairs, walking downstairs, sitting, standing and laying) while wearing a smartphone on the waist.

The file has 180 rows (30 subjects times 6 activities) and 68 columns, with one row for each combination of subject and activity. The first two columns identify the row (`subject` and `activity`), and the other 66 are measurements.

Each value in the 66 measurement columns is the average of that measurement over all the time windows recorded for that subject performing that activity. The original measurements are normalized and bounded between -1 and 1.

## Variables

### Identifiers

`subject`: integer from 1 to 30 that identifies each volunteer.

`activity`: text with the activity the subject was performing. It has 6 possible values, which were coded as numbers in the original data:

| Original code | Value in `activity` |
|---|---|
| 1 | WALKING |
| 2 | WALKING_UPSTAIRS |
| 3 | WALKING_DOWNSTAIRS |
| 4 | SITTING |
| 5 | STANDING |
| 6 | LAYING |

Each combination of `subject` and `activity` appears exactly once in the file.

### Measurements (66 variables)

The names are read in this order: domain, source, sensor, jerk (optional), magnitude (optional), statistic and axis (optional).

- **Domain**: `Time` (signal in time) or `Frequency` (signal in frequency).
- **Source**: `Body` (body movement) or `Gravity` (gravity).
- **Sensor**: `Accelerometer` (acceleration) or `Gyroscope` (angular velocity).
- **Jerk**: derivative of the signal in time.
- **Magnitude**: magnitude of the three directions.
- **Statistic**: `Mean` or `StandardDeviation`.
- **Axis**: `X`, `Y` or `Z`. It only appears in the signals that are not magnitudes.

Example: `TimeBodyAccelerometerMeanX` is the mean of the body acceleration, in the time domain, along the X axis. There are 48 variables with an axis (8 signals times 3 axes times 2 statistics) and 18 magnitude variables (9 signals times 2 statistics), for a total of 66.

For more detail on the signals, see `features_info.txt` and `README.txt` in the original dataset.

## Transformations

The script `run_analysis.R` starts from the original UCI HAR Dataset and transforms it as follows:

1. **Reading.** If the folder `UCI HAR Dataset` does not exist, the zip file is downloaded and unzipped. Eight files are read: `X`, `y` and `subject` for the training (train) and test sets, `features.txt` and `activity_labels.txt`.

2. **Merging train and test.** Within each set, the subject identifier (`subject`), the activity (`y`) and the 561 measurements (`X`) are combined column-wise (`cbind`). The files share no key column, so they are matched by position: row n of each file corresponds to the same time window. The two sets are then stacked row-wise (`rbind`). Result: 10299 rows and 563 columns.

3. **Selecting means and standard deviations.** The columns are named `subject`, `activity` and the 561 names from `features.txt`. The columns kept are `subject`, `activity` and those whose name contains `mean()` or `std()`, that is, 66 measurements. `meanFreq()` and the `angle()` variables are excluded because they are not the mean or standard deviation of a measured signal. Result: 10299 rows and 68 columns.

4. **Activity names.** The activity codes (1 to 6) are replaced by their names according to `activity_labels.txt`.

5. **Variable names.** Abbreviations are expanded: `t` becomes `Time`, `f` becomes `Frequency`, `Acc` becomes `Accelerometer`, `Gyro` becomes `Gyroscope`, `Mag` becomes `Magnitude`, `mean()` becomes `Mean` and `std()` becomes `StandardDeviation`. Hyphens and parentheses are removed, and the typo `BodyBody` in the original dataset is corrected (it becomes `Body`).

6. **Tidy data set.** The data are grouped by `subject` and `activity`, and the average of each of the 66 measurements is computed within each group. Result: 180 rows (30 subjects times 6 activities) and 68 columns, saved as `tidy_data.txt` with `write.table(..., row.names = FALSE)`.
