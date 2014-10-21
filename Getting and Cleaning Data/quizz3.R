# Ian Castillo Rosales
# 27072014

setwd("~/Desktop/repos/datasciencecoursera/Getting and Cleaning Data")

# Pregunta 1
if(!file.exists("communities.csv")){
      url_file <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
      download.file(url_file, "communities.csv")
}

data <- read.csv("communities.csv")
agricultureLogical <- data$ACR ==3 & data$AGS == 6
which(agricultureLogical)[1:3] # Devuelve el índice en el que TRUE aparece

# Pregunta 2
install.packages("jpeg")
library(jpeg)
if(!file.exists("pic.jpg")){
      url_pic <- "http://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
      download.file(url_pic, "pic.jpg")
}

picture <- readJPEG("pic.jpg", native = T)
quantile(picture, c(.30))
quantile(picture, c(.80))

# Pregunta 3
if(!file.exists("gross.csv")){
      url_file <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
      download.file(url_file, "gross.csv")
}

if(!file.exists("educational.csv")){
      url_file <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
      download.file(url_file, "educational.csv")
}

data_gross <- read.csv("gross.csv", as.is = T)
data_gross <- data_gross[5:194, c(1,2,4,5)]
colnames(data_gross) <- c("Country", "Ranking", "Name", "US Dollars")
data_gross$Ranking <- as.numeric(data_gross$Ranking)

data_educational <- read.csv("educational.csv", as.is = T)

data_gross <- data_gross[data_gross$Country %in% data_educational$CountryCode, ]
data_educational <- data_educational[data_educational$CountryCode %in% data_gross$Country, ]

data_educational <- data_educational[match(data_gross$Country, data_educational$CountryCode), ]

data <- cbind(data_gross, data_educational)
sort_data <- data[sort(data$Ranking, decreasing = T), ]

# Pregunta 4
mean(data$"Ranking"[data$Income.Group == "High income: OECD"])
mean(data$"Ranking"[data$Income.Group == "High income: nonOECD"])

# Pregunta 5
data$ranking_data <- cut(data$Ranking, quantile(data$Ranking, c(0, 0.20, 0.40, 0.60, 0.80, 1)))
sum(data$Income.Group == "Lower middle income" & data$ranking_data == levels(data$ranking_data)[1])
