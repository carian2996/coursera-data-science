Code Book
======================================

This file describes the variables, the data, and any transformations or work that is performed to clean up the data.

## The data
The source of the data can find in the next url:
http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A description of the data can find in the next link:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Transform and clean the row data
All the data is load in the next tables:

      - data_train
      - label
      - subject_train
      - data_test
      - label_test
      - subject_test

Then, merge data is saved in the next three tables:

      - data_joined
      - label_joined
      - subject_joined

features: Contains the features of the activities
activity: Contains the activities for the data
mean_index: Contains the index in which the column is a measureament of the mean or a standar deviation
tidy_data: Contain the tidy set data

## Average Tidy Data (Final Output)
This tidy data set contains the average of each measurement related with mean measurement and standard deviation measurement.
The average was calculate group by subject and activity.

### Variables of avegare_tidy_data.txt
The
