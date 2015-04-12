##PLOT 4
## read in the dataset, do subsetting and formatting ##########################

## read in dataset
dt <- read.table("household_power_consumption.txt",sep=";", stringsAsFactors=FALSE,header=TRUE)

##load libraries
library(plyr)
library(dplyr)
library(lubridate)

##convert to dplyr table dataframe
dt2 <- tbl_df(dt)

##create DateTime field
dt3 <- mutate(dt2,DateTime = dmy_hms(paste(dt2$Date,dt2$Time,sep=" ")))

##subset data to get readings for just 2007-02-01 and 2007-02-02 -- something is wrong, this doesn't work
dt4 <- filter(dt3,as.Date(DateTime) >= as.Date("2007-02-01"),as.Date(DateTime) <= as.Date("2007-02-02") )

##replace '?' with NA in all fields
dt4[as.character(dt4)=="?"]<-NA

## create the plot ###############################################
par(mfrow=c(2,2),mar=c(5,5,1,1))
#1
plot(dt4$DateTime,as.double(dt4$Global_active_power),ylab="Global Active Power",xlab="",type="l")
#2
plot(dt4$DateTime,as.double(dt4$Voltage),ylab="Voltage",xlab="datetime",type="l")
#3
plot(dt4$DateTime,as.double(dt4$Sub_metering_1),ylab="Energy sub metering",xlab="",type="l")
lines(dt4$DateTime,as.double(dt4$Sub_metering_2),col="red")
lines(dt4$DateTime,as.double(dt4$Sub_metering_3),col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1),bty="n",inset=0,cex=0.7)

#4
plot(dt4$DateTime,as.double(dt4$Global_reactive_power),ylab="Global_reactive_power",xlab="datetime",type="l")

##write to png file
dev.copy(png, file = "plot4.png")
dev.off()