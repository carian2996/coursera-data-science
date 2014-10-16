# Ian Castillo Rosales
# 14102014

# Set the working directory in the place where you're going to work
dir_work <- "~/Desktop/repos/datasciencecoursera/Getting and Cleaning Data/assignment_2"
setwd(dir_work)

require(dplyr)

# ========== Download the data ==========
if(!file.exists("data.zip")){
      url_file <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(url_file, "data.zip")
}

# Unzip the data if the data isn't already unziped
if(!file.exists("UCI HAR Dataset")){
      unzip("data.zip") 
}

# ========== Read the data ==========
data_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
label_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

data_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
label_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# ========== 1 Merge the data ==========
data_joined <- rbind(data_train, data_test) # Join the train and test data in one set
label_joined <- rbind(label_train, label_test) # Join the train and test labels in one set
subject_joined <- rbind(subject_train, subject_test) # Join the train and test subjects in one set

# ========== 2 Extracting the mean and std measurements ==========
# Load the features from the file and make it readable
features <- read.table("./UCI HAR Dataset/features.txt")
features[, 2] <- gsub("\\(\\)", "", features[, 2]) # remove "()"
features[, 2] <- gsub("-", " ", features[, 2]) # remove "-" in column names 

# Extract only features releated with mean or standard deviation
mean_index <- grep("mean | std", features[, 2])

# Keep only the features releated with mean or standard deviation
data_joined <- data_joined[, mean_index]

# ========== 3 Name the activities and subjects in the data set ==========
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
label_joined <- tolower(activity[label_joined[, 1], 2])

# Merge the sets into an only tidy data set
tidy_data <- cbind(subject_joined, label_joined, data_joined)
tidy_data <- arrange(tidy_data, Subject, Activity)

# Name the variables with descriptive names
names(tidy_data) <- c("Subject", "Activity", as.character(features[mean_index, 2]))
# tidy_data[, 1] <- apply(tidy_data[,1], 1, function(x) paste("Subject", x))

# ========== 4 Write the text file ==========
write.table(tidy_data, "tidy_data.txt")

# ========== Create a new set of data ==========
new_data <- tidy_data
unique(tidy_data$Subject)

