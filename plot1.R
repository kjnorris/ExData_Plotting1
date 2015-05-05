# Coursera - JHU Exploratory Data Analysis
# Author: Kenneth Norris
# Date: 5 May 2015

# Project 1 - Plot 1

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
png(filename = paste(getwd(), "plot1.png", sep = "/"),
    bg = "transparent", width = 480, height = 480, units = "px")

# Plot histogram - Global Active Power
hist(selectPower$GlobalActivePower, col = "Red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     ylim = c(0, 1200), xlim = c(0,6))
dev.off()



