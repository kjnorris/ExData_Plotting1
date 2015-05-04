# Load libraries used in the script
library(dplyr)
library(lubridate)

# Specify file from Data directory
powerFile <- paste(getwd(), "Data",
                   "household_power_consumption.txt", sep = "/")

# Set column headings for the data frame
powerCols <- c("Date", "Time", "GlobalActivePower", "GlobalReactovePower",
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
selectPower <- rbind(filter(powerData, Date == ymd("2007-02-01")),
                     filter(powerData, Date == ymd("2007-02-02")))

# Save plot as png - 480x480 pixels
png(filename = paste(getwd(), "plot2.png", sep = "/"),
    bg = "white", width = 480, height = 480, units = "px")

# Plot histogram
plot(GlobalActivePower ~ DateTime, selectPower,
     type = "l",
     xlab = " ",
     ylab = "Global Active Power (kilowatts)")
dev.off()