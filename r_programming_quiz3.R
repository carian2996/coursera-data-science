# Ian Castillo Rosales
# R Programming
# 18062014

# ===== Question 1 =====
library(datasets)
data(iris)
?iris
data(mtcars)
?mtcars

head(iris)
levels(iris$Species)
medias <- sapply(split(iris, iris$Species), function(x) colMeans(x[, colnames(iris)[1:4]]))
medias["Sepal.Length", "virginica"]

virginica <- split(iris, iris$Species)$virginica
mean(virginica$Sepal.Length)

mean(iris$Sepal.Length[iris$Species=="virginica"])

# ===== Question 2 =====
class(iris)
apply(iris, 2, mean) # Contiene la variable "Species"
apply(iris[, 1:4], 2, mean) # Solo contiene las variables numéricas

# ===== Question 3 =====
head(mtcars)
sapply(split(mtcars$mpg, mtcars$cyl), mean)

# ===== Question 4 =====
medias_hp_cilindro <- sapply(split(mtcars$hp, mtcars$cyl), mean)

abs(medias_hp_cilindro[1] - medias_hp_cilindro[3])

# ===== Question 5 =====
debug(ls)
ls()
