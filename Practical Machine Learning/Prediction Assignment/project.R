# Ian Castillo Rosales
# Course Project - Practical Machine Learning
# Jan, 23th. 2015

#Settings and packages
setwd("~/Desktop/repos/datasciencecoursera/Practical Machine Learning/Prediction Assignment")
library(lattice)
library(ggplot2)
library(caret)
library(rattle)
library(randomForest)

url <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
download.file(url, destfile = "train.csv", method = "curl")
train <- read.csv("train.csv", na.strings=c("NA","#DIV/0!",""), header = T)

# ===== Target variable =====
class(train$classe); levels(train$classe)

# ===== Useless variables =====
# Remove the index and user variables
train <- train[, -c(1, 2, grep("time", names(train)))]

# ===== NA values =====
# How many predictores have all their values equal to NA?
sum(colSums(is.na(train)) == nrow(train))
keep <- which(colSums(is.na(train)) < 19000)
train <- train[, keep]

nzv <- nearZeroVar(train, saveMetrics = T)

test <- read.csv("test.csv", na.strings=c("NA","#DIV/0!",""), header = T)
test <- test[, -c(1, 2, grep("time", names(test)))]
test <- test[, keep]

colnames(train[, -55]) == colnames(test)
test[, which(!sapply(train, class) == sapply(test, class))] <- sapply(test[, which(!sapply(train, class) == sapply(test, class))], as.numeric)
test[, 55] <- as.factor(test[, 55])

# ===== Model =====
set.seed(1111)
indexTrain <- createDataPartition(train$classe, p = 0.60, list = F)
trTrain <- train[indexTrain, ]
teTrain <- train[-indexTrain, ]

train_control <- trainControl(method="cv", number=10)
rfModel <- randomForest(classe ~ ., trControl = train_control, data = trTrain)
rfPred <- predict(rfModel, newdata = teTrain)

confusionMatrix(rfPred, teTrain$classe)

rfModel2 <- randomForest(classe ~ ., preProcess = "pca", trControl = train_control, data = trTrain)
rfPred2 <- predict(rfModel2, newdata = teTrain)
confusionMatrix(rfPred2, teTrain$classe)

levels(test$new_window) <- c("no", "yes")

test <- test[colnames(train[, -55])]
predictions <- predict(rfModel, test)

pml_write_files = function(x){
      n = length(x)
      for(i in 1:n){
            filename = paste0("problem_id_",i,".txt")
            write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
      }
}

pml_write_files(predictions)
