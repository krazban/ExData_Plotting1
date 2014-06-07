#
#plot3.R
#
# Requirements: 
# * flat text data file "household_power_consumption.txt"
#   must exist in the same location as the script.
# * package data.table must be installed.

require(data.table)

fname <- "household_power_consumption.txt"

# read and extract the data only for the selected days.
powdata<-as.data.frame(suppressWarnings(
        fread(fname,header=T,na.strings='?')
        [Date=="1/2/2007"|Date=="2/2/2007"]))

# correct the format of columns
powdata<-transform(powdata, 
                   Date = as.Date(Date,format="%d/%m/%Y"),
                   Time = strptime(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"),
                   Global_active_power = as.numeric(Global_active_power),	
                   Global_reactive_power = as.numeric(Global_reactive_power),
                   Voltage = as.numeric(Voltage),
                   Global_intensity = as.numeric(Global_intensity),
                   Sub_metering_1 = as.numeric(Sub_metering_1),
                   Sub_metering_2 = as.numeric(Sub_metering_2),
                   Sub_metering_3 = as.numeric(Sub_metering_3))

# Create the plot and save in figure directory
png(filename = "figure/plot3.png",width = 480, height = 480, units = "px")

with(powdata, plot(Time, Sub_metering_1, type="n", 
                   ylab = "Energy sub metering", xlab = ""))
with(powdata, lines(Time, Sub_metering_1))
with(powdata, lines(Time, Sub_metering_2, col="red"))
with(powdata, lines(Time, Sub_metering_3, col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       col=c("black","red","blue") )       
dev.off()
# END