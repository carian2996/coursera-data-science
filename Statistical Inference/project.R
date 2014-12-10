# Ian Castillo Rosales
# Project - Statistical Inference - Data Science Specialization
# 10102014

# Set my working directory
setwd("~/Desktop/repos/datasciencecoursera/Statistical Inference")

# Parameters
lambda <- 0.2
n_sim <- 40
n <- 1000
media <- 1/lambda
sd <- 1/lambda

medias <- NULL
for(i in 1:n) medias <- c(medias, mean(rexp(n_sim, lambda)))

hist(medias, main = "Distribution of the averages on forty exp(0.2)", xlab = "lambda", freq = F)
abline(v = 1/lambda, col = "red", lwd = 1.5)
legend("topright", legend = "Mean", col = "red", cex = 0.8, pch = 16)

x <- seq(min(medias), max(medias), length = n)
normales <- dnorm(x, mean = media, sd = sd/sqrt(n_sim))
lines(x, normales, col = "blue")
legend("topright", legend = c("Mean", "Theorical Dist"), col = c("red", "blue"), cex = 0.8, pch = 16)

abs((1/lambda)^2 - var(medias)*n_sim)