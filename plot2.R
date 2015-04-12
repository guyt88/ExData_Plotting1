##PLOT 2
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
par(mar=c(5,5,2,2))
plot(dt4$DateTime,as.double(dt4$Global_active_power),ylab="Global Active Power (kilowatts)",xlab="",type="l")

##write to png file
dev.copy(png, file = "plot2.png")
dev.off()
