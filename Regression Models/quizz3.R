# Ian Castillo Rosales
# Quizz 3 - Regression Models
# 08/10/2014

# Question 1
data(mtcars)
fit <- lm(mpg ~ factor(cyl) + wt, mtcars)
coef(fit)[3]

# Question 2
data(mtcars)
fit1 <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
fit2 <- lm(mpg ~ factor(cyl), data = mtcars)
summary(fit1)
summary(fit2)
# Holding weight constant, cylinder appears to have less of an impact on mpg than if weight is disregarded.

# Question 3
data(mtcars)
fit1 <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
fit2 <- lm(mpg ~ factor(cyl) + wt + interaction(cyl, wt), data = mtcars)
# To compare model we usually use an anova table
# anova null hypothesis says that both models are the same.
anova(fit1, fit2)
# The P-value is larger than 0.05. So, according to our criterion, 
# we would fail to reject, which suggests that the interaction may not be necessary.

# Question 4
# Consider the mtcars data set. 
# Fit a model with mpg as the outcome that includes number of cylinders as a 
# factor variable and weight inlcuded in the model as
lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)
# note : ton = 2 tonnes
# The estimated expected change in MPG per one ton increase in weight 
# for a specific number of cylinders (4, 6, 8).

# Question 5 FAIL
# Consider the following data set
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
# Give the hat diagonal for the most influential point
fit <- lm(y ~ x)
hatvalues(fit) # 0.9946

# Question 6 FAIL
# Consider the following data set
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
# Give the slope dfbeta for the point with the highest hat value.
fit <- lm(y ~ x)
dfbetas(fit) # 134

# Question 7
# It is possible for the coefficient to reverse sign after adjustment. 
# For example, it can be strongly significant and positive before adjustment 
# and strongly significant and negative after adjustment.