
library(data.table)
filelocation <-"/Data/hhelectricity/" #set to appropriate directory
setwd(filelocation)
fexists <- file.exists("mydat.RDS")

if(!fexists){
mydata <- fread("household_power_consumption.txt", na.strings='?')
mydata[, Date := as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S")]
mydat <- mydata[Date>="2007-02-01"&Date<"2007-02-03",]
mydat[, Global_active_power:=as.numeric(Global_active_power)]
setkey(mydat, Date)
saveRDS(mydat, "mydat.RDS")
} else {mydat <- readRDS("mydat.RDS")}


#+Plot4
png("plot4.png") #defaults are 480x480
par(mfrow=c(2,2))
plot(mydat$Date, mydat$Global_active_power, type="l",
     ylab="Global Active Power", xlab="")
plot(mydat$Date, mydat$Voltage, type="l",lwd=0.05,
     ylab="Voltage", xlab="datetime")
plot(mydat$Date, mydat$Sub_metering_1, type="l",
     ylab="Energy sub metering", xlab="")
     lines(mydat$Date, mydat$Sub_metering_2, col="red")
     lines(mydat$Date, mydat$Sub_metering_3, col="blue")
     legend('topright', c("Sub_metering_1","Sub_metering_2",
                     "Sub_metering_3"), 
       lty=1, col=c('black','red', 'blue'), cex=.75)
plot(mydat$Date, mydat$Global_reactive_power, type="l", lwd=0.05,
     ylab="Global_reactive_power", xlab="datetime")
dev.off()


