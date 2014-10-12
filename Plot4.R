# Read the 1st row only and store as headers
headers <- read.csv("household_power_consumption.txt",
                    header=F,
                    sep=";",
                    stringsAsFactors=F,
                    nrow=1)

# Read the middle of the file for the days Feb 1,2007 and Feb 2, 2007
hpc <- read.csv("household_power_consumption.txt",
                header=F,
                sep=";",
                na.strings="?",
                stringsAsFactors=F,
                col.names=headers,
                nrows=2880,
                skip=66637)

# Add a new column that is stored in POSIXlt for date manipulation
hpc$DateTime <- strptime(paste(hpc$Date,hpc$Time),"%d/%m/%Y %H:%M:%S")

png("Plot4.png", width = 480, height = 480)

par(mfrow=c(2,2), mar = c(4,4,2,2))

# Create first plot
within(hpc, 
       plot(DateTime,
            Global_active_power, 
            type = "l",
            ylab = "Global Active Power",
            xlab = "")
)

# Create second plot
within(hpc, 
       plot(DateTime,
            Voltage,
            type = "l",
            ylab = "Voltage",
            xlab = "datetime")
       )

# Create third plot
within(hpc, 
       plot(DateTime,
            Sub_metering_1,
            type = "n",
            ylab = "Energy sub metering",
            xlab = "")
)

within(hpc, points(DateTime,Sub_metering_1,type="l"))
within(hpc, points(DateTime,Sub_metering_2,type="l",col="red"))
within(hpc, points(DateTime,Sub_metering_3,type="l",col="blue"))

legend("topright", 
       lty = 1, 
       cex = 0.9,
       bty="n",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black","red","blue"))


# Create forth plot
within(hpc, 
       plot(DateTime,
            Global_reactive_power, 
            type = "l",
            ylab = "Global_reactive_power",
            xlab = "datetime")
)

dev.off()