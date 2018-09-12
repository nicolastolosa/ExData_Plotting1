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
colclass <- c("character", "character", "numeric", "numeric", "numeric", "NULL", "numeric", "numeric", "numeric")
data <- read.table(file,header=T, sep =";", colClasses = colclass , na.strings = "?")


## GIVE FORMAT AND FILTER DATA
## Date and Time are merged into a unique POSIXct variable called "Date"

data$Date <- as.POSIXct (paste(data$Date,data$Time), format = "%d/%m/%Y %H:%M:%S", tz="GMT")
data <- select(data, -Time) %>% filter(Date >= as.POSIXct("2007-02-01 00:00:00", tz="GMT") & Date <= as.POSIXct("2007-02-02 23:59:59", tz= "GMT"))



##------------------------------------PLOT 4------------------------------------


png("plot4.png", width = 480, height = 480)

par(mfcol=c(2,2), mar=c(4,4,2,2))

plot(data$Date,data$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(data$Date,data$Global_active_power)

plot(data$Date,data$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(data$Date,data$Sub_metering_1, col="black")
lines(data$Date,data$Sub_metering_2, col="red")
lines(data$Date,data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=1, box.lwd=0, cex=0.7)

plot(data$Date,data$Voltage, type="n", xlab="datetime", ylab="Voltage")
lines(data$Date,data$Voltage)

plot(data$Date,data$Global_reactive_power, type="n", xlab="datetime", ylab="Global Reactive Power")
lines(data$Date,data$Global_reactive_power)

dev.off()

