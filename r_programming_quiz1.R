x <- c(4, "a", T)
class(x)

x1 <- c(1, 3, 5)
x2 <- c(3, 2, 10)

cbind(x1, x2)

x3 <- 1:4
x4 <- 2:3

class(x3 + x4)

data <- read.csv("hw1_data.csv")
data[1:2, ]

nrow(data)
data[(nrow(data)-1):nrow(data), ]

data$Ozone[47]

sum(is.na(data$Ozone))

mean(data$Ozone[!is.na(data$Ozone)])

data_new <- data[complete.cases(data$Ozone, data$Temp, data$Solar.R), ]
mean(data_new$Solar.R[data_new$Ozone > 31 & data_new$Temp > 90])

mean(data$Temp[ data$Month == 6 ])

max(data$Ozone[ data$Month==5 & !is.na(data$Ozone) ])
