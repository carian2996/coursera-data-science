# Ian Castillo Rosales
# Quizz 3 - Statistical Inference - Data Science
# 20112014

# Question 1
n <- 9
s_mean <- 1100
sd <- 30
alpha <- 0.05

s_mean + c(-1, 1)*qt(1 - alpha/2, n-1)*(sd/sqrt(n))

# Question 2
diff_mean <- -2
n <- 9
alpha <- 0.05
t_quantil <- qt(1 - alpha/2, n-1)
(-diff_mean*sqrt(n)) / t_quantil

# Question 3.
# Independent tests: not related participants
# Paired tests: related participants, same group uses 2 different tests
# A paired interval.

# Question 4
n_x <- 10
n_y <- 10
mean_mwt_new <- 3
mean_mwt_standart <- 5
var_mwt_new <- 0.6
var_mwt_standart <- 0.68
alpha <- 0.05

sp2 <- ((n_x-1)*var_mwt_standart + (n_y-1)*var_mwt_new)/(n_x+n_y-2)
sp <- sqrt(sp2)
(mean_mwt_new - mean_mwt_standart) + c(-1, 1)*qt(1-alpha/2, n_x+n_y-2)*sp*sqrt(1/n_x + 1/n_y)

# Question 5
# 90% confidence interval gives a lower t-value then 95% confidence interval. 
# => The interval will be narrower.

# Question 6
n_x <- 100
n_y <- 100
mean_mwt_new <- 4
mean_mwt_standart <- 6
var_mwt_new <- 0.5
var_mwt_standart <- 2
alpha <- 0.05

sp2 <- ((n_x-1)*var_mwt_standart^2 + (n_y-1)*var_mwt_new^2)/(n_x+n_y-2)
sp <- sqrt(sp2)
(mean_mwt_standart - mean_mwt_new) + c(-1, 1)*qt(1-alpha/2, n_x+n_y-2)*sp*sqrt(1/n_x + 1/n_y)

# Question 7
n_x <- 9
n_y <- 9
x_bar <- -3
y_bar <- 1
s_x <- 1.5
s_y <- 1.8
alpha <- 0.1
sp_2 <- ((n_x - 1)*s_x^2 + (n_y - 1)*s_y^2) / (n_x + n_y - 2)
sp <- sqrt(sp_2)
ts <- qt(1 - (alpha/2), n_x + n_y - 2)
round((x_bar - y_bar) + c(-1, 1) * ts * sp * (sqrt(1/n_x + 1/n_y)), 3) 