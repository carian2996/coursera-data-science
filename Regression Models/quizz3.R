# Ian Castillo Rosales
# Quizz 3 - Regression Models
# 08/10/2014

# Question 1
data(mtcars)
fit <- lm(mpg ~ factor(cyl) + wt, mtcars)
summary(fit)

# Question 2
data(mtcars)

fit1 <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
fit2 <- lm(mpg ~ factor(cyl), data = mtcars)

fit2$coefficients[3]

# Question 3
data(mtcars)

fit1 <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
fit2 <- lm(mpg ~ factor(cyl) + wt + interaction(cyl, wt), data = mtcars)

# To compare model we usually use an anova table
# anova null hypothesis says that both models are the same.
compare <- anova(fit1, fit2)
compare$Pr

# Question 4
# Consider the mtcars data set. 
# Fit a model with mpg as the outcome that includes number of cylinders as a 
# factor variable and weight inlcuded in the model as
lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)
# How is the wt coefficient interpretted?


# note : ton = 2 tonnes
# The estimated expected change in MPG per one ton increase in weight for a specific number of cylinders (4, 6, 8).

# Question 5
# Consider the following data set

x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

# Give the hat diagonal for the most influential point

fit <- lm(y ~ x)
hatvalues(fit)

# Question 6
# Consider the following data set

x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
# Give the slope dfbeta for the point with the highest hat value.

fit <- lm(y ~ x)
dfbetas(fit)
