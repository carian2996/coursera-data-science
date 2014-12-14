# Question 1
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
fit <- lm(y~x)
summary(fit)

# Question 2
e <- resid(fit)
(res.sd <- sqrt(sum(e^2) / (length(e) - 2)))

# Question 3
data(mtcars)
attach(mtcars)
fit <- lm(mpg ~ wt, mtcars)
summary(fit)
exp <- fit$coefficients[1] + mean(wt) * fit$coefficients[2]
exp - 2 * 0.5591

# Question 4
# The estimated expected change in mpg per 1,000 lb increase in weight.
?mtcars

# Question 5 Error
summary(fit)
fit[[1]][1] + 3 * fit[[1]][2]

# Question 6
summary(fit)
2 * (fit$coefficients[2] - 2 * 0.5591)

# Question 7
# Multiplied by 100

# Question 8
# hat(b0) c*hat(b1)

# Question 9
attributes(fit)
w.c <- fit$residuals ^ 2
fit.c <- lm(mpg ~ 1, mtcars)
fit.c.res <- fit.c$residuals ^ 2
sum(fit.c.res)
sum(w.c) /sum(fit.c.res)

# Question 10
# If the intercept is included, the sum of the residuals will be 0
