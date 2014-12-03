library(dplyr)
library(lubridate)

#Read in the dataset
hpower <- read.csv("./household_power_consumption.txt", sep=";", na.string=c("?"))

# Convert Date and Time strings to an actual datetime, add as a column called datetime to hpower
times <- strptime(paste(as.Date(hpower[, 1], format="%d/%m/%Y"), hpower[,2]), "%Y-%m-%d %H:%M:%S")
dateTime <- data.frame(times)
hpower["datetime"] <- dateTime[,1]

#Subset hpower so that it only contains data for dates 2007-02-01 and 2007-02-02 inclusive, assign to mypower
hpower[hpower$datetime >= strptime("2007-02-01", "%Y-%m-%d") & hpower$datetime < strptime("2007-02-03", "%Y-%m-%d"), ] -> mypower

#Remove any rows with NAs
mypower <- mypower[complete.cases(mypower), ]

#Write the final dataset to a file (remove this later)
#write.table(mypower, file="./mypower.csv", quote=TRUE, sep=',', eol='\r\n', row.names=FALSE, col.names=TRUE)

#Create the appropriate plot in png files
#plot1
png(file="./plot1.png", width = 480, height = 480, units = "px")
hist(mypower$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()

