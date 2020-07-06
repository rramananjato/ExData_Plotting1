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
                 Global_active_power=as.numeric(Global_active_power),
                 Global_reactive_power=as.numeric(Global_reactive_power),
                 Voltage=as.numeric(Voltage),
                 Global_intensity=as.numeric(Global_intensity),
                 Sub_metering_1=as.numeric(Sub_metering_1),
                 Sub_metering_2=as.numeric(Sub_metering_2),
                 Sub_metering_3=as.numeric(Sub_metering_3))

## creating plot
png("plot1.png", width = 480, height = 480, units = "px")
with(subdata, hist(Global_active_power, col="red",
                   main="Global Active Power",
                   xlab="Global Active Power (kilowatts)",
                   axes=FALSE,
                   ylim= c(0, 1200),
                   breaks=c(0,250,500,750,1000,1250,1500,1750,2000,
                           2250,2500,2750,3000,3250,3500,3750,4000)
                   )
     )
axis(1, at=c(0,1000,2000,3000), labels=c(0,2,4,6))
axis(2, at=c(0,200,400,600,800,1000,1200), labels=TRUE)

dev.off()
