# Ian Castillo Rosales
# 12072014

setwd("~/Desktop/repos/datasciencecoursera/Getting and Cleaning Data")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile="communities.csv", method="curl")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf ", destfile="communities.pdf", method="curl")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", destfile="natural_gas.xlsx", method="curl")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv ", destfile="communities_idaho.csv", method="curl")

# 1
data <- read.csv("communities.csv")
class(data$VAL)
sum(data$VAL>=24, na.rm=T)


# 3
install.packages("xlsx")
install.packages("rJava")
install.packages("xlsxjars")
library(xlsx)
rows <- 18:23
cols <- 7:15
dat <- read.xlsx("natural_gas.xlsx", sheetIndex=1, rowIndex=rows, colIndex=cols)
sum(dat$Zip*dat$Ext,na.rm=T)

# 4
install.packages("XML")
library(XML)
doc <- xmlTreeParse("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", useInternalNodes=T)
class(doc)

raiz <- xmlRoot(doc)
names(raiz)
raiz[[1]][[1]]

zips <- xpathSApply(doc, "//zipcode", xmlValue)
sum(zips=="21231")

# 5

install.packages("data.table")
library(data.table)

DT <- fread("communities_idaho.csv")
class(DT)



mean(DT[DT$SEX==1,]$pwgtp15)
mean(DT[DT$SEX==2,]$pwgtp15)

system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(tapply(DT$pwgtp15,DT$SEX,mean))





