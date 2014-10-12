
library(data.table)
fexists <- file.exists("mydat.RDS")

if(!fexists){
setwd("/Data/hhelectricity/")
mydata <- fread("household_power_consumption.txt", na.strings='?')
mydata[, Date := as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S")]
mydat <- mydata[Date>="2007-02-01"&Date<"2007-02-03",]
setkey(mydat, Date)
saveRDS(mydat, "mydat.RDS")
} else {mydat <- readRDS("mydat.RDS")}

