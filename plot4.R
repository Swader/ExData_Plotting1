list.of.packages <- c("sqldf")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

file <- c("household_power_consumption.txt");
data <- read.csv.sql(file, "select * from file where Date in ('1/2/2007','2/2/2007')", header=T, sep=';')

data$DateTime <- paste(data$Date, data$Time)
data$DateTimePosixCt <- as.POSIXct(data$DateTime, format='%d/%m/%Y %H:%M:%S')

# Plot 1 - GAP over time
plot(
  data$DateTimePosixCt, 
  data$Global_active_power, 
  ylab = "Global Active Power", 
  xlab = "",
  type = "n"
)

lines(data$DateTimePosixCt, data$Global_active_power)

# Plot 2 - Voltage over time
plot(
  data$DateTimePosixCt, 
  data$Voltage, 
  ylab = "Voltage", 
  xlab = "",
  type = "n"
)

lines(data$DateTimePosixCt, data$Voltage)

# Plot 3 - submetering over time

plot(
  data$DateTimePosixCt, 
  data$Sub_metering_1, 
  ylab = "Energy sub metering", 
  xlab = "",
  type = "n"
)

lines(data$DateTimePosixCt, data$Sub_metering_1)
lines(data$DateTimePosixCt, data$Sub_metering_2, col="red")
lines(data$DateTimePosixCt, data$Sub_metering_3, col="blue")

legend(
  "topright", 
  legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"), 
  text.col=c("black", "red", "blue"), 
  lty=c(1,1,1), 
  col=c("black", "red", "blue"),
  cex = 0.75,
  bty = "n"
)

# Plot 4 - GRP over time

plot(
  data$DateTimePosixCt, 
  data$Global_reactive_power,  
  ylab = "Global Reactive Power", 
  xlab = "",
  type = "n"
)

lines(data$DateTimePosixCt, data$Global_reactive_power)

# Export

dev.copy(png, 'plot4.png')
dev.off()