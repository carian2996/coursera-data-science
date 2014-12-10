# Ian Castillo Rosales
# Quizz 1 - Regression Models
# 08/10/2014

# Question 1
x <- c(0.18, -1.54, 0.42, 0.95)
w <- c(2, 1, 3, 1)
sol <- c(0.3, 0.1471, 0.0025, 1.077)

# Derivando la ecuación sobre la variable mu, igualando a 0 y despejando se tiene que
(minimo <- (sum(w*x))/sum(w))

# Question 2
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
data <- data.frame(x, y)

fit <- lm(y ~ 0 + x, data)
fit$coefficients

# Question 3
fit <- lm(mtcars$mpg~mtcars$wt, mtcars)
fit$coefficients[2]

# Question 4
# b1 = cor(X, Y)*( sd(Y) / sd(X) )
# b1 = (1/2)*( 2*sd(X) / sd(X) ) = 1

# Question 5
1.5*0.4

# Question 6
x <- c(8.58, 10.46, 9.01, 9.64, 8.86)
media <- mean(x)
de <- sd(x)
(x_norm <- (x-media)/de)[1]

# Question 7
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
data <- data.frame(x, y)
fit <- lm(y ~ x, data)
fit$coefficients[1]

# Question 8
# hat(b0) = bar(Y) - bar(X)*hat(b1)
# hat(b0) = 0 - 0*hat(b1) = 0

# Question 9
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
mean(x)

# Question 10
# b1 = slope(Y~X)
# g1 = slope(X~Y)
# => b1 / g1 = (cor(X,Y)*sdY)/sdX) / (cor(Y,X)*sdX)/sdY
#            = sdY^2 / sdX^2
#            = varY / varX
