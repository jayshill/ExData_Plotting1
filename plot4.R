## Download and read the data into R
# Check if a data directory exists; if not, create one
if(!file.exists("data")) {
    dir.create("data")
}
#download and unzip the data file
datafile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(datafile, destfile=".\\data\\datafile.zip", method="auto")
unzip(".\\data\\datafile.zip", exdir=".\\data")
# read the datafile into R
columnNames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
electric <- read.table(file=".\\data\\household_power_consumption.txt", header=F, sep=";", skip=1,  col.names=columnNames, na.strings="?")

## Clean up the data and subset only the days we want.
# coerce date to R format
electric$Date <- as.Date(as.character(electric$Date), format="%d/%m/%Y")
# subset by the dates we want
twoDays <- electric[electric$Date=="2007-02-01" | electric$Date=="2007-02-02",]
# convert time to R format
twoDays$Time <- paste(twoDays$Date, twoDays$Time, sep=" ")
twoDays$Time <- as.POSIXct(twoDays$Time)


## Save the plot to a PNG file
png("plot4.png", bg="transparent")
par(mfcol=c(2,2))

plot(x=twoDays$Time, 
     y=twoDays$Global_active_power, 
     type="l", 
     main="", 
     xlab="", 
     ylab="Global Active Power")

plot(twoDays$Time, 
     twoDays$Sub_metering_1, 
     type="l", 
     col="black", 
     main="", 
     xlab="", 
     ylab="Energy sub metering")
lines(twoDays$Time, twoDays$Sub_metering_2, col="red")
lines(twoDays$Time, twoDays$Sub_metering_3, col="blue")
legend(x="topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, 
       col=c("black", "red", "blue"))

plot(twoDays$Time, 
     twoDays$Voltage, 
     type="l", 
     main="", 
     xlab="datetime", 
     ylab="Voltage")

plot(twoDays$Time, 
     twoDays$Global_reactive_power, 
     type="l", 
     main="", 
     xlab="datetime", 
     ylab="Global_reactive_power")

dev.off()
