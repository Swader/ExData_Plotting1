list.of.packages <- c("sqldf")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

file <- c("household_power_consumption.txt");
data <- read.csv.sql(file, "select * from file where Date in ('1/2/2007','2/2/2007')", header=T, sep=';')

data$DateTime <- paste(data$Date, data$Time)
data$DateTimePosixCt <- as.POSIXct(data$DateTime, format='%d/%m/%Y %H:%M:%S')

plot(
  data$DateTimePosixCt, 
  data$Sub_metering_1, 
  main="Global Active Power", 
  ylab = "Global Active Power (kilowatts)", 
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
  col=c("black", "red", "blue")
)

dev.copy(png, 'plot3.png')
dev.off()
