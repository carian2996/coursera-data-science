# Ian Castillo Rosales
# Quizz 4 - Practical Machine Learning
# 27/01/2015

library(lattice)
library(ggplot2)
library(caret)
library(rattle)
library(gbm)

# ===== Question 1 =====
library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

train <- vowel.train
test <- vowel.test

train$y <- factor(train$y)
test$y <- factor(test$y)

set.seed(33833)

rfModel <- train(y ~ ., method = "rf", data = train)
booModel <- train(y ~ ., method = "gbm", data = train)

rfpred <- predict(rfModel, test)
boopred <- predict(booModel, test)

confusionMatrix(rfpred, test$y) # 0.6061
confusionMatrix(boopred, test$y) # 0.5303

# ===== Question 2 =====
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)

frModel <- train(diagnosis ~ ., method = "rf", data = training)
botModel <- train(diagnosis ~ ., method = "gbm", data = training)
ldaModel <- train(diagnosis ~ ., method = "lda", data = training)

frpred <- predict(frModel, testing)
botpred <- predict(botModel, testing)
ldapred <- predict(ldaModel, testing)

predDF <- data.frame(frpred, botpred, ldapred, diagnosis = testing$diagnosis)
combModel <- train(diagnosis ~ ., method = "rf", data = predDF)
combpred <- predict(combModel, testing$diagnosis)

confusionMatrix(frpred, testing$diagnosis) # 0.7683
confusionMatrix(botpred, testing$diagnosis) # 0.7927 ***
confusionMatrix(ldapred, testing$diagnosis) # 0.7683

confusionMatrix(combpred, predDF$diagnosis) # 0.8049

# ===== Question 3 =====
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(233)

lassoModel <- train(CompressiveStrength ~ ., method = "lasso", data = training)
plot.enet(lassoModel$finalModel, xvar = "penalty", use.color = T) #cement

# ===== Question 4 =====
url <- "http://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv"
download.file(url = url, destfile = "nvisit.csv", method = "curl")
nvisit <- read.csv("nvisit.csv")

library(lubridate)  # For year() function below
training = nvisit[year(nvisit$date) < 2012,]
testing = nvisit[(year(nvisit$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

library("forecast")
foreModel <- bats(tstrain)
prediction <- forecast(foreModel, h = nrow(testing), level = 95)

accuracy(prediction, testing$visitsTumblr)

result <- c()
l <- length(prediction$lower)

for (i in 1:l){
      x <- testing$visitsTumblr[i]
      a <- prediction$lower[i] < x & x < prediction$upper[i]
      result <- c(result, a)
}

sum(result)/l * 100 # 96 %

# ===== Question 5 =====
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(325)

library(e1071)

svmModel <- svm(CompressiveStrength ~ ., data = training)
predictions <- predict(svmModel, testing)
library(Metrics)
rmse(testing$CompressiveStrength, predictions) # 6.72
