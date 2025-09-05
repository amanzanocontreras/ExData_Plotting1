df <- read.table(
  "./individual+household+electric+power+consumption/household_power_consumption.txt",
  sep=";", 
  header=TRUE, 
  na.strings="?"
)

df$Date <- as.Date(df$Date, format="%d/%m/%Y")

data_filtered <- subset(df, Date %in% as.Date(c("2007-02-01","2007-02-02")))

data_filtered$DateTime <- as.POSIXct(
  paste(data_filtered$Date, data_filtered$Time),
  format="%Y-%m-%d %H:%M:%S"
)

# Sanity check
head(data_filtered)
dim(data_filtered)


png("plot1.png", width=480, height=480)
hist(data_filtered$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()


png("plot2.png", width=480, height=480)
plot(data_filtered$DateTime, data_filtered$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")
dev.off()


png("plot3.png", width=480, height=480)
plot(data_filtered$DateTime, data_filtered$Sub_metering_1, type="l",
     xlab="", ylab="Energy sub metering")
lines(data_filtered$DateTime, data_filtered$Sub_metering_2, col="red")
lines(data_filtered$DateTime, data_filtered$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()


png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# Top-left
plot(data_filtered$DateTime, data_filtered$Global_active_power, type="l",
     xlab="", ylab="Global Active Power")

# Top-right
plot(data_filtered$DateTime, data_filtered$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

# Bottom-left
plot(data_filtered$DateTime, data_filtered$Sub_metering_1, type="l",
     xlab="", ylab="Energy sub metering")
lines(data_filtered$DateTime, data_filtered$Sub_metering_2, col="red")
lines(data_filtered$DateTime, data_filtered$Sub_metering_3, col="blue")
legend("topright", lty=1, bty="n", col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Bottom-right
plot(data_filtered$DateTime, data_filtered$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")

dev.off()

