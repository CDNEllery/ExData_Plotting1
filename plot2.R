# plot2.R

# Set working directory
setwd("C:/Users/eo6405/Desktop/Misc - R/Coursera/Exploratory Data Analysis/Week 1/exdata%2Fdata%2Fhousehold_power_consumption")

# Read in a subset of the table, required dates are 01/02/2007, 02/02/2007
subset_datatable <- read.table("household_power_consumption.txt",header = TRUE,stringsAsFactors = FALSE, 
                               sep = ";", col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
                                                        "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                               skip=grep("^31/1/2007", readLines("household_power_consumption.txt" )), nrows=4320)

        required_dates <- subset(subset_datatable, Date == "1/2/2007" | Date == "2/2/2007")

# Sort out NA's
        required_dates[required_dates == "?"] <- NA

# Convert to date time
        # Paste Date and Time together to Date_Time
        required_dates$Date_Time <- paste(required_dates$Date, required_dates$Time, " ")
        class(required_dates$Date_Time)
        # Convert to POSIXct
        required_dates$Date_Time <- as.POSIXct(strptime(required_dates$Date_Time,format="%d/%m/%Y %H:%M:%S"))
        class(required_dates$Date_Time)
        # Convert Date field to w-day
        required_dates$Day <- weekdays(required_dates$Date_Time)
        
# Change graphics device
        dev.cur()        
        png("rplot2.png", width = 480, height = 480)
        
# Hisogram is a line graph
        ?plot
        with(required_dates, plot(Date_Time, Global_active_power, type = "l", xlab = "", ylab = ""))
        title(xlab = NULL, ylab = "Global Active Power (kilowatts)")
        
# Close the connection with the PNG graphics device
        dev.off()
        