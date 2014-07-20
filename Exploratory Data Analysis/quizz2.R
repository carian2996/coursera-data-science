# Ian Castillo Rosales
# 20072014

# Pregunta 2
library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)

# Pregunta 5
?trellis.par.set
?print.trellis

# Pregunta 9
library(ggplot2)
g <- ggplot(movies, aes(votes, rating))
print(g)

# Pregunta 10
qplot(votes, rating, data = movies) 
qplot(votes, rating, data = movies) + geom_smooth()