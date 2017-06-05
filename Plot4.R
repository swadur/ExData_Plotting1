## Week 1 - Programming Assignment - Exploratory Data
## Suleman Wadur

## Load needed libraries
library(dplyr)


## Set working directory
workdir <- "C:/Move 4/Coursera/DataScience/Course4-ExploratoryDataAnalysis/Week1/assignment"
setwd(workdir)

## directory check and data download
if(!file.exists("./data")) {
  dir.create("./data")
}


fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/Dataset.zip")

## Unzip data and save in same directory
unzip(zipfile="./data/Dataset.zip", exdir="./data")

## Load the data from the zipped file.
powerConsumption <- tbl_df(read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?"))

## converts Date column to date class
powerConsumption$Date <- as.Date(powerConsumption$Date, "%d/%m/%Y")

## subsets only data that are between 2007-02-01 and 2007-02-02
powerConsumption <- subset(powerConsumption,Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

## casts the necessary columns used in creating the plots
powerConsumption$Global_active_power <- as.numeric(powerConsumption$Global_active_power)
powerConsumption$Global_reactive_power <- as.numeric(powerConsumption$Global_reactive_power)
powerConsumption$Voltage <- as.numeric(powerConsumption$Voltage)
powerConsumption$Sub_metering_1 <- as.numeric(powerConsumption$Sub_metering_1)
powerConsumption$Sub_metering_2 <- as.numeric(powerConsumption$Sub_metering_2)
powerConsumption$Sub_metering_3 <- as.numeric(powerConsumption$Sub_metering_3)

## removes any row that may have missing data
consumptionData <- powerConsumption[complete.cases(powerConsumption),]

## uses mutate function to merger date and time columns to a single column
consumptionData <- mutate(consumptionData, DateTime=paste(Date, Time))

## casts the DateTime column to date time format
consumptionData$DateTime <- as.POSIXct(consumptionData$DateTime)

## defines some of the global parameters needed to create 2 rows & 2 cols of plots
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))


## generate the 4 plots.
with(consumptionData, {
  plot(Global_active_power~DateTime, ylab = "Global active power", xlab="", type = "l")
  plot(Voltage~DateTime, ylab = "Voltage", xlab="datetime", type = "l")
  plot(Sub_metering_1~DateTime, ylab = "Energy sub metering", xlab="", type = "l")
  lines(Sub_metering_2~DateTime, type = "l", col = "Red")
  lines(Sub_metering_3~DateTime, type = "l", col = "Blue")
  legend("topright", col=c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
         , bty = "n", lty = 1)
  plot(Global_reactive_power~DateTime, ylab = "Global reactive power", xlab="datetime", type = "l")
})

## Creates a PNG file of the plot.
dev.copy(png, file = "plot4.png", height = 480, width = 480)

## closes the PNG device
dev.off()



