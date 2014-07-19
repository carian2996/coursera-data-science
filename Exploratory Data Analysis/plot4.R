# Ian Castillo Rosales
# 13072014

# Set your working directory
setwd("~/Desktop/repos/datasciencecoursera/Exploratory Data Analysis/Course Project 1/")

# Download the data
FileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(FileURL, destfile = "data.zip", method = "curl")
unzip("data.zip", exdir=".") # Unzip the data

# Load the data
data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", skip = 66637, nrows = 2880, as.is = T)
colnames(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                    "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Set the correct classes
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")

# Open the device and create the .png file
png(file = "./figure/plot4.png", width = 480, height = 480)

# Plot
par(mfrow = c(2, 2))
plot(data$Global_active_power, type="l", ylab="Global Active Power", xlab="", xaxt="n")
axis(1,c("Thu", "Fri", "Sat"), at=c(1, which(weekdays(data$Date)=="Friday")[1], nrow(data)+1))

plot(data$Voltage, type="l", ylab="Voltage", xlab="datetime", xaxt="n")
axis(1,c("Thu", "Fri", "Sat"), at=c(1, which(weekdays(data$Date)=="Friday")[1], nrow(data)+1))

plot(data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="", xaxt="n")
lines(data$Sub_metering_1)
lines(data$Sub_metering_2, col="red")
lines(data$Sub_metering_3, col="blue")
axis(1,c("Thu", "Fri", "Sat"), at=c(1, which(weekdays(data$Date)=="Friday")[1], nrow(data)+1))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

plot(data$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime", xaxt="n")
axis(1,c("Thu", "Fri", "Sat"), at=c(1, which(weekdays(data$Date)=="Friday")[1], nrow(data)+1))

dev.off()