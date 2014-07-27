# Ian Castillo Rosales
# 27092014

setwd("~/Desktop/repos/datasciencecoursera/Getting and Cleaning Data/assignment_2")

# Download and unzip the data in the workspace
if(!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")){
      url_file <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(url_file, "data.zip")
}
unzip("data.zip")

# ========== Read the train data ==========
data_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
label_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# ========== Read the test data ==========
data_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
label_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# ========== Join the data ==========
data_joined <- rbind(data_train, data_test)
label_joined <- rbind(label_train, label_test)
subject_joined <- rbind(subject_train, subject_test)

# ========== Extracting the mean and std measurement ==========
features <- read.table("./UCI HAR Dataset/features.txt")
mean_index <- grep("mean\\(\\)|std\\(\\)", features[, 2])

data_joined <- data_joined[, mean_index]

names(data_joined) <- gsub("\\(\\)", "", features[mean_index, 2]) # remove "()"
names(data_joined) <- gsub("-", "", names(data_joined)) # remove "-" in column names 

# ========== Name the activities in the data set ==========
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")

label_joined[, 1] <- activity[label_joined[, 1], 2]
names(label_joined) <- "activity"

# ========== Labels the data set with descriptive variable names ==========
names(label_joined) <- "subject"
cleanedData <- cbind(subject_joined, label_joined, data_joined)

# ========== Write the text file ==========
write.table(cleanedData, "merged_data.txt")
