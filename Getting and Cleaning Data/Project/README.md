Getting and Cleaning Data: Course Project
=========================================

Introduction
------------
This directory contains the work I did for the course project for the Coursera course "Getting and Cleaning Data". Included is the function that will perform the requested task, and the codebook defining the workflow of the function, the variables, and other relevant pieces of information.

What was asked:
------------

The following data was provided:
[UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The following webpage provides more information on the dataset:
[Human Activity Recognition using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the required steps to complete the project, as taken directly from the relevant Coursera webpage:

>You should create one R script called run_analysis.R that does the following.
>
>1. Merges the training and the test sets to create one data set.
>2. Extracts only the measurements on the mean and standard deviation for each measurement.
>3. Uses descriptive activity names to name the activities in the data set
>4. Appropriately labels the data set with descriptive activity names.
>5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

How to use the program:
------------------

1. Download the above mentioned data source and unzip it on your local computer.
2. In the same directory which now contains the 'UCI HAR Dataset' directory, download or `git clone` this directory, or just the ```run_analysis.R``` file.
3. **ATTENTION:** You have to now use the `setwd()` command in R, or RStudio to set the directory with ```run_analysis.R``` and the 'UCI HAR dataset' directory as the working director.
4. Following that you may import the function using `source('./run_analysis.R')`
5. You may now run the function with `data <- runAnalysis()`. The resulting data will be stored in the `data` variable, but also in a newly created .txt file named, 'tidyData.txt' in the same folder as the program.
