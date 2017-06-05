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

## converts the Global_active_power column to numeric
powerConsumption$Global_active_power <- as.numeric(powerConsumption$Global_active_power)

## removes any row that may have missing data
consumptionData <- powerConsumption[complete.cases(powerConsumption),]

## generates a histogram showing the distribution of the Global_Active_power column
hist(consumptionData$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "Red")

## Creates a PNG file of the plot.
dev.copy(png, file = "plot1.png", height = 480, width = 480)

## closes the PNG device
dev.off()