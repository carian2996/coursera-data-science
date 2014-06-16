# Ian Castillo Rosales
# Pollutant Mean - Coursera - R Programming - Assigenment 1: Air Pollution
# 16062014

pollutantmean <- function(directorio, contaminante, id = 1:332) {
      x <- c() # Vector to contain all the data from the files
      
      for(i in seq_along(id)) {
            data <- read.csv(paste(getwd(), "/", directorio, "/", sprintf("%03s", id[i]), ".csv", sep="")) # Read the data from the ID sequence
            x <- c(x, data[, contaminante]) # Read only the specified pollutant
      }
      
      mean(x, na.rm=T) # Return the mean witout NA's
}