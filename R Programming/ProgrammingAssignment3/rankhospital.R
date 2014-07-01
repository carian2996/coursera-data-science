# Ian Castillo Rosales
# R Programming - Assignment 3
# 30062014

rankhospital <- function(estado, resultado, num) {
      
      # Lectura de los datos
      data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
      data <- data[c(2, 7, 11, 17, 23)]
      names(data) <- c("name", "state", "heart attack", "heart failure", "pneumonia")
      
      # Validación de los resultados
      res_validos <-  c("heart attack", "heart failure", "pneumonia")
      if(all(is.na(match(res_validos, resultado)))==T){
            stop("invalid outcome")
      }
      
      # Validación del estado
      est_validos <- data[, 2]
      est_validos <- unique(est_validos)
      if(all(is.na(match(est_validos, estado)))==T){ 
            stop("invalid state")
      }
      
      # Validación del valor num
      if( num != "best" && num != "worst" && num%%1 != 0 ){
            stop("invalid num")
      }
      
      ## Grab only rows with our state value    
      data <- data[data$state==estado & data[resultado] != 'Not Available', ]
      
      ## Order the data
      data[resultado] <- as.data.frame(sapply(data[resultado], as.numeric))
      data <- data[order(data$name, decreasing = FALSE), ]
      data <- data[order(data[resultado], decreasing = FALSE), ]
      
      ## Process the num argument
      vals <- data[, resultado]
      if( num == "best" ) {
            rowNum <- which.min(vals)
      } else if( num == "worst" ) {
            rowNum <- which.max(vals)
      } else {
            rowNum <- num
      }
      
      ## Return hospital name in that state with lowest 30-day death rate
      data[rowNum, ]$name
}

rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)