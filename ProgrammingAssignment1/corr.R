# Ian Castillo Rosales
# Correlation - Coursera - R Programming - Assigenment 1: Air Pollution
# 16062014

corr <- function(directorio, umbral = 0) {
      source("~/Desktop/repos/datasciencecoursera/complete.R") # Call complete function
      correlaciones <- numeric(0) # Create a correlations vector
      
      completos <- complete(directorio) # Put all the complete cases
      id <- completos$id[completos$comple_cases > umbral] # Idenfity all the cases where complete cases is above umbral variable
      for(i in seq_along(id)) {
            data <- read.csv(paste(getwd(), "/", directorio, "/", sprintf("%03s", id[i]), ".csv", sep="")) # Read the data from the ID sequence
            correlaciones[i] <- cor(x=data$"sulfate", y=data$"nitrate", use="pairwise.complete.obs") # Calculates the correlation
      }
      correlaciones # Present the table
}