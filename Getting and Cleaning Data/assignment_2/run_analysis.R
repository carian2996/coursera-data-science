# Ian Castillo Rosales
# 14102014 - 21102014
# Data Science Specialization - Getting and Cleaning Data 

# Set the working directory in the place where you're going to work
dir_work <- "~/Desktop/repos/datasciencecoursera/Getting and Cleaning Data/assignment_2"
setwd(dir_work)

require(dplyr) # Install (if is the case) and load dplyr package for data manipulation

# ========== Download the data ==========
if(!file.exists("data.zip")){
      url_file <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(url_file, "data.zip")
}

# Unzip the data if the data isn't already unziped
if(!file.exists("UCI HAR Dataset")){
      unzip("data.zip") 
}

# ========== Read the data from .txt files ==========
data_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
label_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

data_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
label_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# ========== 1 Merge the data from test and train ==========
data_joined <- rbind(data_train, data_test) # Join the train and test data in one set
label_joined <- rbind(label_train, label_test) # Join the train and test labels in one set
subject_joined <- rbind(subject_train, subject_test) # Join the train and test subjects in one set

# ========== 2 Extracting the mean and std measurements ==========
# Load the features from the file and make it readable
features <- read.table("./UCI HAR Dataset/features.txt")
features[, 2] <- gsub("\\(\\)", "", features[, 2]) # remove "()" in column names 
features[, 2] <- gsub("-", "_", features[, 2]) # remove "-" in column names 
# Extract only features releated with mean or standard deviation
mean_index <- grep("mean|std", features[, 2])
# Keep only the features releated with mean or standard deviation
data_joined <- data_joined[, mean_index]

# ========== 4 Name the activities and subjects in the data set ==========
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
label_joined <- tolower(activity[label_joined[, 1], 2])
# Merge the sets into an only tidy data set
tidy_data <- cbind(subject_joined, label_joined, data_joined)

# ========== 3 Name the variables with descriptive names ==========
names(tidy_data) <- c("subject", "activity", as.character(features[mean_index, 2]))
tidy_data <- arrange(tidy_data, subject, activity)
names(tidy_data)

# ========== 5 Create a new set of data with the average of the variables ==========
new_data <- tidy_data
average_tidy_data <- new_data %>%
      group_by(subject, activity) %>%
      summarise_each(funs(mean))

write.table(average_tidy_data, "average_tidy_data.txt", row.names = FALSE)