# Ian Castillo Rosales
# R Programming - Assignment 3
# 30062014

best <- function(estado, resultado){
      
      # Lectura de los datos
      datos <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
      datos <- datos[, c(2, 7, 11, 17, 23)]
      names(datos) <- c("name", "state", "heart attack", "heart failure", "pneumonia")
      
      # Validación de los resultados
      res_validos <-  c("heart attack", "heart failure", "pneumonia")
      if(all(is.na(match(res_validos, resultado)))==T){
            stop("invalid outcome")
      }
      
      # Validación del estado
      est_validos <- datos[, 2]
      est_validos <- unique(est_validos)
      if(all(is.na(match(est_validos, estado)))==T){ 
            stop("invalid state")
      }
      
      # Datos del estado en especifico
      datos <- datos[datos$state==estado & datos[, resultado] != 'Not Available', ]
      validos <- datos[, resultado]
      RoW <- which.min(validos)
      # Devuélve el nombre donde existe una tasa minima de acuerdo al resultado pedido
      datos[RoW, ]$name
}