# Ian Castilo Rosales
# Getting and Cleaning Data - Data Science Specialization
# 29102014 - Quizz 4

setwd("~/Desktop/repos/datasciencecoursera/Getting and Cleaning Data")

# Question 1
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if(!file.exists("communities.csv")){
      download.file(url, "communities.csv")
}

data <- read.csv("communities.csv")
strsplit(names(data), "wgtp")[123]

# Question 2
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
if(!file.exists("grossdomesticproduct.csv")){
      download.file(url, "grossdomesticproduct.csv")
}

data <- read.csv("grossdomesticproduct.csv")
mean(as.numeric(gsub(",", "", data$X.3[5:194])))

# Question 3
grep("^United", data$X.2[5:194])

# Question 4
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
if(!file.exists("educationaldata.csv")){
      download.file(url, "educationaldata.csv")
}

dataeducation <- read.csv("educationaldata.csv")
dataeducation2 <- dataeducation[na.omit(match(data$X[5:194], dataeducation$CountryCode)), ]

junefiscal <- dataeducation2[unique(grep("Fiscal year end: June", dataeducation2$Special.Notes)), ]
nrow(junefiscal)

# Question 5
library(quantmod)
library(lubridate)

amzn <- getSymbols("AMZN",auto.assign=FALSE)
sampleTimes <- index(amzn)

sum(year(sampleTimes) == "2012")
sum(wday(sampleTimes) == 2 & year(sampleTimes) == "2012")
