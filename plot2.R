## charging packages
library(plyr)

## reading data
data <- read.csv("household_power_consumption.txt", header=T, sep=";", dec=".")

## formatting Date and Time
subdata <- mutate(data, Date=as.Date(Date, "%d/%m/%Y"))
subdata <- mutate(subdata, Time=strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S"))

## select only Dates between 2007-02-01 and 2007-02-02
subdata <- subset(subdata, (Date>=as.Date("2007-02-01", "%Y-%m-%d")
                            & Date<=as.Date("2007-02-02", "%Y-%m-%d")))

## setting other variables to be numeric
subdata <- mutate(subdata, 
                  Global_active_power=as.numeric(Global_active_power)/500,
                  Global_reactive_power=as.numeric(Global_reactive_power),
                  Voltage=as.numeric(Voltage),
                  Global_intensity=as.numeric(Global_intensity),
                  Sub_metering_1=as.numeric(Sub_metering_1),
                  Sub_metering_2=as.numeric(Sub_metering_2),
                  Sub_metering_3=as.numeric(Sub_metering_3))

## creating plot
png("plot2.png", width = 480, height = 480, units = "px")
with(subdata,plot(Time,Global_active_power,
                  type="l", ylab="Global Active Power (kilowatts)",
                  xlab=" ", axes=T,
                  )
     )
dev.off()