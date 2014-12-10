# Ian Castillo Rosales
# Project - Statistical Inference - Data Science Specialization
# 10102014

# Set my working directory
setwd("~/Desktop/repos/datasciencecoursera/Statistical Inference")
library(datasets)
data(ToothGrowth)

data <- ToothGrowth
str(data)

summary(data$len)
hist(data$len)

table(data$supp)
table(data$dose)

t.test(data)