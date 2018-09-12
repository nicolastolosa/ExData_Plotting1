##CHARGE LIBRARIES
library(dplyr)


## Download and unZip data 
## (This step can be ignored if the data already has been downloaded)

##URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
##download.file(URL, "original_data.zip")

##zipF<- paste0(getwd(),"/original_data.zip")
##outDir<- getwd()
##unzip(zipF,exdir=outDir)

##---------------------------------PREPARE DATA---------------------------------

## READ DATA 
## columns that were not needed have been excluded with colClasses="NULL"

file <- "household_power_consumption.txt"
colclass <- c("character", "character", "numeric", "NULL", "NULL", "NULL", "numeric", "numeric", "numeric")
data <- read.table(file,header=T, sep =";", colClasses = colclass , na.strings = "?")


## GIVE FORMAT AND FILTER DATA
## Date and Time are merged into a unique POSIXct variable called "Date"

data$Date <- as.POSIXct (paste(data$Date,data$Time), format = "%d/%m/%Y %H:%M:%S", tz="GMT")
data <- select(data, -Time) %>% filter(Date >= as.POSIXct("2007-02-01 00:00:00", tz="GMT") & Date <= as.POSIXct("2007-02-02 23:59:59", tz= "GMT"))



##------------------------------------PLOT 1------------------------------------


png("plot1.png", width = 480, height = 480)
par(mar=c(5,4,4,0.5))
hist(data$Global_active_power, breaks = 11, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power", xaxp=c(0,6,3), yaxp=c(0,1200,6))
dev.off()
