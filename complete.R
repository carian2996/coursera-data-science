# Ian Castillo Rosales
# Complete - Coursera - R Programming - Assigenment 1: Air Pollution
# 16062014

complete <- function(directorio, id = 1:332) {
      x <- data.frame("id"=id, "comple_cases"=rep(0, length(id))) # Data frame for the id sequence
      
      for(i in seq_along(id)) {
            data <- read.csv(paste(getwd(), "/", directorio, "/", sprintf("%03s", id[i]), ".csv", sep="")) # Read the data from the ID sequence
            x[i, 2] <- sum(complete.cases(data[, 1], data[, 2], data[, 3], data[, 4])) # Count the complete cases for the data
      }
      
      x # Present the table
}