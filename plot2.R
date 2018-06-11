################################
## Coursera Specialization:   ##
## Exploratory Data Analysis  ##
## JHU                        ##
## Assignment week1           ##
## Electric Power Consumption ##
## PLOT 2                     ##
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
####################
## Plotting graph ##
####################     
wday = weekdays(as.Date(newDt[,1]), abbreviate = TRUE) # converting to weekdays for display on x-axis
plot(newDt[,2], type='l', ylab="Global Active Power (kilowatts)", xlab="", axes=FALSE)
axis(side=1, at=c(1,1550, 2881), labels=c(wday[1], wday[1550], 'Sat')) # last point to be displayed at element 2881 and defined manually
axis(side=2, at=c(0,2,4,6))
box()
 
## Saving plot to a PNG file
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()


