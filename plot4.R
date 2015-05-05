# Coursera - JHU Exploratory Data Analysis
# Author: Kenneth Norris
# Date: 5 May 2015

# Project 1 - Plot 4

# Load libraries used in the script
library(lubridate)

# Specify file from Data directory
powerFile <- paste(getwd(), "Data",
                   "household_power_consumption.txt", sep = "/")

# Set column headings for the data frame
powerCols <- c("Date", "Time", "GlobalActivePower", "GlobalReactivePower",
               "Voltage", "GlobalIntensity", "SubMetering1",
               "SubMetering2", "SubMetering3")

# Load power consumption data into powerData data frame
powerData <- read.table(powerFile, header = TRUE, sep = ";",
                        col.names = powerCols, na.strings = "?",
                        stringsAsFactors = FALSE)

# Combine date and time and format as POSIX using lubridate
powerData$DateTime <- dmy_hms(paste(as.character(powerData$Date),
                                    as.character(powerData$Time), sep = " "))

# Convert Date from character to POSIX Date
powerData$Date <- dmy(powerData$Date)

# Filter to 2007-02-01 and 2007-02-02
selectPower <- subset(powerData,
                      Date == ymd("2007-02-01") |
                          Date == ymd("2007-02-02"))

# Save plot as png - 480x480 pixels
png(filename = paste(getwd(), "plot4.png", sep = "/"),
    bg = "transparent", width = 480, height = 480, units = "px")

# Set global graphics parameters
par(mfcol = c(2, 2))

# Upper left line graph - Global Active Power by Date/Time
plot(GlobalActivePower ~ DateTime, selectPower,
     type = "l",
     xlab = " ",
     ylab = "Global Active Power")

# Lower left line graph - 3 Submetering reads by Date/Time
plot(SubMetering1 ~ DateTime, selectPower,
     type = "l", col = "black",
     xlab = " ",
     ylab = "Energy sub metering")
lines(SubMetering2 ~ DateTime, selectPower,
      type = "l", col = "red")
lines(SubMetering3 ~ DateTime, selectPower,
      type = "l", col = "blue")
legend("topright",
       col = c("black", "red", "blue"),
       lty = c(1, 1, 1), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Upper right line graph - Voltage by Date/Time
plot(Voltage ~ DateTime, selectPower,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Lower right line graph - Global Reactive Power by Date/Time
plot(GlobalReactivePower ~ DateTime, selectPower,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()