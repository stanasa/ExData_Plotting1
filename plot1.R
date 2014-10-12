
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

#+Plot1
png("plot1.png") #defaults are 480x480
hist(mydat$Global_active_power, xlab="Global Active Power (kilowatts)",
     main="Global Active Power", col="red")
dev.off()

