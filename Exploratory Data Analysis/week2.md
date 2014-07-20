# Lattice Plotting System
Paquete lattice, grind.
Especificar las notaciones y detalles en una sola función
High dimensional plotting. Múltiples gráficas. 

´´´
library(lattice)
library(datasets)
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Winf | Month, data = airquality, layout =c(5, 1))
´´´

## El comportamiento de Lattice
Regresa un objeto llamado trellis, que se auto grafica.

## Panel function()

# ggplot2 System