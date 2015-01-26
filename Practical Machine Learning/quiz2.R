# Ian Castillo Rosales
# Quizz 1 - Practical Machine Learning
# 12/01/2015

# ===== Question 1 =====
library(AppliedPredictiveModeling)
library(caret)
data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]

# ===== Question 2 =====
data(concrete)
library(ggplot2)
library(Hmisc)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

summary(training)

index <- 1:nrow(training)
ggplot(training, aes(x=index, y=CompressiveStrength, colour=cut2(training$Age, g=4))) + geom_point()
ggplot(training, aes(x=index, y=CompressiveStrength, colour=cut2(training$FlyAsh, g=4))) + geom_point()

# ===== Question 3 =====
data(concrete)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

summary(training$Superplasticizer)
hist(training$Superplasticizer)

# ===== Question 4 =====
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

predictorsIL <- predictors[, substr(names(predictors), 1, 2) == "IL"]
preProc <- preProcess(predictorsIL, method = "pca", thresh = 0.8)
preProc

# ===== Question 5 =====
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

newdata <- cbind(training[, substr(names(training), 1, 2) == "IL"], training$diagnosis)
names(newdata)[13] <- "diag"

inTrain = createDataPartition(newdata$diag, p = 3/4)[[1]]
training2 = newdata[ inTrain,]
testing2 = newdata[-inTrain,]

modelFit <- train(diag ~ ., method = "glm", data = training2)
predictions1 <- predict(modelFit, newdata = testing2)

modelFitPCA <- train(diag ~ ., method = "glm", preProcess = "pca", data = training2, trControl = trainControl(preProcOptions = list(thresh = 0.8)))
predictions2 <- predict(modelFitPCA, newdata = testing2)

confusionMatrix(predictions1, testing2$diag)
confusionMatrix(predictions2, testing2$diag)
