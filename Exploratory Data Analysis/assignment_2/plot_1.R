# Ian Castillo Rosales
# 27072014

# ========== Set the working space and options ==========
setwd("~/Desktop/repos/datasciencecoursera/Exploratory Data Analysis/assignment_2/")
options(scipen=999)

# ========== Set the libraries ==========
library(plyr)
library(ggplot2)

# ========== Load the data ==========
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# ========== Creat the plot 1 ==========
agg_data <- with(NEI, aggregate(Emissions, by = list(year), sum))

plot(agg_data, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Total Emissions in the US")
polygon(aggregate.data, col = "blue")

# ========== Creat the plot 2 ==========
NEI_24510 <- NEI[which(NEI$fips == "24510"), ]
agg_24510 <- with(NEI_24510, aggregate(Emissions, by = list(year), sum))
colnames(agg_24510) <- c("year", "Emissions")

plot(agg_24510, type = "l", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Total Emissions for Baltimore", xlim = c(1999, 2008))

# ========== Creat the plot 3 ==========
NEI_24510 <- NEI[which(NEI$fips == "24510"), ]
agg_24510 <- with(NEI_24510, aggregate(Emissions, by = list(year), sum))
colnames(agg_24510) <- c("year", "Emissions")

NEI_24510.type <- ddply(NEI_24510, .(type, year), summarize, Emissions = sum(Emissions))
NEI_24510.type$Pollutant_Type <- NEI_24510.type$type

qplot(year, Emissions, data = NEI_24510.type, group = Pollutant_Type, color = Pollutant_Type, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")

# ========== Creat the plot 4 ==========
SCC_coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCC_coal <- SCC[SCC_coal, ]
SCC_ident <- as.character(SCC_coal$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI.coal <- NEI[NEI$SCC %in% SCC_ident, ]

agg_coal <- with(NEI.coal, aggregate(Emissions, by = list(year), sum))
colnames(agg_coal) <- c("year", "Emissions")

plot(agg_coal, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Emissions and Total Coal Combustion for the US", 
     xlim = c(1999, 2008))
polygon(agg_coal, col = "blue")
