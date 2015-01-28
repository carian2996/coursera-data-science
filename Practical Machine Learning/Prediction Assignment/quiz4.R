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

rfresults <- confusionMatrix(rfpred, test$y)
booresults <- confusionMatrix(boopred, test$y)

# ===== Question 2 =====
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)

frModel <- train(diagnosis ~ ., method = "rf", data = training, trControl = trainControl(number = 4))
botModel <- train(diagnosis ~ ., method = "gbm", data = training)
ldaModel <- train(diagnosis ~ ., method = "lda", data = training)

frpred <- predict(frModel, testing)
botpred <- predict(botModel, testing)
ldapred <- predict(ldaModel, testing)

c1 <- confusionMatrix(frpred, testing$diagnosis) # 0.7683
c2 <- confusionMatrix(botpred, testing$diagnosis) # 0.7927 ***
c3 <- confusionMatrix(ldapred, testing$diagnosis) # 0.7683

predDF <- data.frame(frpred, botpred, ldapred, diagnosis = testing$diagnosis)
combModel <- train(diagnosis ~ ., method = "rf", data = predDF)
combpred <- predict(combModel, predDF)

c4 <- confusionMatrix(combpred, predDF$diagnosis) # 0.8048

print(paste(c1$overall[1], c2$overall[1], c3$overall[1], c4$overall[1]))

# ===== Question 3 =====