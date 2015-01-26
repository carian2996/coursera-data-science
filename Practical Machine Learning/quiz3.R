# Ian Castillo Rosales
# Quizz 3 - Practical Machine Learning
# 19/01/2015

library(caret)
library(rattle)
library(AppliedPredictiveModeling)

# ===== Question 1 =====
data(segmentationOriginal)
data <- data.frame(segmentationOriginal)

trainIndex <- data$Case == levels(data$Case)[2]
trainIndex

training <- data[trainIndex, ]
testing <- data[trainIndex == F, ]

set.seed(125) 
fitModel <- train(Class ~ ., method = "rpart", data = training)

fancyRpartPlot(fitModel$finalModel)

# a. PS 
# b. WS 
# c. PS
# d. Not possible to predict 

# ===== Question 2 =====
# The bias is larger and the variance is smaller. 
# Under leave one out cross validation K is equal to the sample size.

# ===== Question 3 =====
set.seed(123)
library(pgmm)
data(olive)
olive <- olive[,-1]

trainIndex <- createDataPartition(olive$Area, p = 0.7, list = F)
train <- olive[trainIndex, ]
test <- olive[-trainIndex, ]

getModelInfo()
treeModel <- train(Area ~ ., method = "rpart", data = train)

newdata = as.data.frame(t(colMeans(olive)))

fancyRpartPlot(treeModel$finalModel)

# 2.875. It is strange because Area should be a qualitative variable - 
# but tree is reporting the average value of Area as a numeric variable 
# in the leaf predicted for newdata

# ===== Question 4 =====
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234)

fitModel <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl, 
                  method = "glm", family = "binomial", data = trainSA)

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

# Test Set
values <- testSA$chd
predictions <- predict(fitModel, testSA)
missClass(values, predictions)

# Train Set
values <- trainSA$chd
predictions <- predict(fitModel, trainSA)
missClass(values, predictions)

# Test Set Misclassification: 0.31 
# Training Set: 0.27

# ===== Question 5 =====
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

vowel.train$y <- factor(vowel.train$y)
vowel.test$y <- factor(vowel.test$y)

set.seed(33833)

rdmforest <- randomForest(y ~ ., data = vowel.train, importance = FALSE)
order(varImp(rdmforest))
# x.2, x.1, x.5, x.6, x.8, x.4, x.9, x.3, x.7,x.10