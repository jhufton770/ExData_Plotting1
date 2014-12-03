library(dplyr)
library(lubridate)
library(sqldf)

#Read in the relevant subset of the total dataset using sqldf
mypower <- read.csv.sql("./household_power_consumption.txt",
                        sql="select * from file where Date in ('1/2/2007', '2/2/2007')", header=TRUE, sep=";")

# Convert Date and Time strings to an actual datetime, add as a column called datetime to mypower
times <- strptime(paste(as.Date(mypower[, 1], format="%d/%m/%Y"), mypower[,2]), "%Y-%m-%d %H:%M:%S")
dateTime <- data.frame(times)
mypower["datetime"] <- dateTime[,1]

#Remove any rows with NAs
mypower <- mypower[complete.cases(mypower), ]

#Create the appropriate plots in png files
#plot2
png(file="./plot2.png", width = 480, height = 480, units = "px")
with(mypower, plot(datetime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()
