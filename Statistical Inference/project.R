# Ian Castillo Rosales
# Project - Statistical Inference - Data Science Specialization
# 10102014

# Set my working directory
setwd("~/Desktop/repos/datasciencecoursera/Statistical Inference")

# Parameters
lambda <- 0.2
n_sim <- 100000
n <- 1000

data_sim <- matrix(rep(rexp(n_sim, lambda), n), nrow = n, ncol = n_sim)
medias <- apply(data_sim, 1, mean)

mean(medias)

hist(medias, breaks = "FD")
abline(v = 1/lambda, col = "red", lwd = 1.5)

