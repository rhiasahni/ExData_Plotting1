################################
## Coursera Specialization:   ##
## Exploratory Data Analysis  ##
## JHU                        ##
## Assignment week1           ##
## Electric Power Consumption ##
## PLOT 4                     ##
##                            ##
## Rhia Sahni                 ##
## June 10, 2018              ##
################################

rm(list=ls())
setwd('/Users/rhiasahni/Desktop/Rcodes/coursera/course4/week1')

#######################################################################
## Reading the data between dates 01/02/2007 and 02/02/2007          ##
## I have chosen to subset the data using the system command "grep"  ##
## rather than having to read large files in system memory.          ##
##                                                                   ##
## The result being saved in datafile subsetDt.txt                   ##
## which has the same format as household_power_consumption.txt      ##
#######################################################################
system('grep -we "Date" -we "1/2/2007" -we  "2/2/2007" household_power_consumption.txt  > subsetDt.txt')
dt= read.csv(file="subsetDt.txt", sep=";", colClasses = c(rep("character",2), rep("numeric",7))) 
dim(dt) #a datamatrix of size 2880x9

#####################################################################################################
## Converting date from character to as.date format                                                ##
## NOTE: rather than converting column 1 (DATE) from character to date format and then             ##
## converting column 2 (TIME) from character to time, I have chosen to merge these two separate    ##
## colums to a single colum called dateTime, which is then converted to date format.               ##  
##                                                                                                 ##
## The new merged matrix will have only 8 columns (single column for date and time) instead of 9   ##
## columns as in the original file.                                                                ##
#####################################################################################################
mergeCol = paste(dt[,1],dt[,2]) 
dateTime = strptime(mergeCol, "%d/%m/%Y %H:%M:%S")
newDt = cbind(dateTime, dt[,3:9])
dim(newDt) #a datamatrix of size 2880x8

rm(subsetDt, dt, mergeCol, dateTime)  # cleaning up memory
######################
## Plotting graph 4 ##
######################     
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(newDt, {plot(Global_active_power~dateTime, type="l", ylab="Global Active Power (kilowatts)",  xlab="")
plot(Voltage~dateTime, type="l", ylab="Voltage (volt)", xlab="")
plot(Sub_metering_1~dateTime, type="l", ylab="Global Active Power (kilowatts)",  xlab="")
lines(Sub_metering_2~dateTime,col='Red')
lines(Sub_metering_3~dateTime,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(Global_reactive_power~dateTime, type="l", ylab="Global Rective Power (kilowatts)")
})

 
## Saving plot to a PNG file
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()


