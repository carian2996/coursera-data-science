# Ian Castillo Rosales
# R Programming - Assignment 3
# 30062014

setwd("~/Desktop/repos/datasciencecoursera/R Programming/ProgrammingAssignment3")

hospitals <- read.csv("hospital-data.csv", colClasses="character")
outcome <- read.csv("outcome-of-care-measures.csv", colClasses="character")

class(outcome)
str(outcome)
dim(outcome)
names(outcome)
head(outcome)

# ===== Death Mortality =====
names(outcome)[11]

outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])

# ===== Hospital Name =====
names(outcome)[2]