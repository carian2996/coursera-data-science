Getting and Cleaning Data Assignment 2
Code Book
======================================

The file describes the variables, the data, and any transformations or work that is performed to clean up the data.

## The variables
All the data is load in the next variable:
      
      - data_train
      - label
      - subject_train
      - data_test
      - label_test
      - subject_test
      
The joined data is saved in the next three variables:

      - data_joined
      - label_joined
      - subject_joined

features: Contains the features of the activities
activity: Contains the activities for the data
mean_index: Contains the index in which the column is a mesureament of the mean or a standar deviation
cleanedData: The data frame with the cleaned and tidy data


## The data
The source of the data can find in the next url:
http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A description of the data can find in the next link:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## run_analysis.R script
This file download, unzip and load the corresponding data for the clean. The script performances the next analysis:

	1. (If doesn't existe) Download the folder with all the data from the University of California archive.
	2. Unzip the folder and put it into the working directory
	3. Load the train data
	4. Load the test data
	5. Merge the correnponding data in one set
	6. Rename the data with the appropriate activities
	7. Labels the data set with descriptive variable names