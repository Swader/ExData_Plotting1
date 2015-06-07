list.of.packages <- c("sqldf")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

file <- c("household_power_consumption.txt");
data <- read.csv.sql(file, "select * from file where Date in ('1/2/2007','2/2/2007')", header=T, sep=';')

data$DateTime <- paste(data$Date, data$Time)
data$DateTimePosixCt <- as.POSIXct(data$DateTime, format='%d/%m/%Y %H:%M:%S')

plot(
  data$DateTimePosixCt, 
  data$Global_active_power, 
  main="Global Active Power", 
  ylab = "Global Active Power (kilowatts)", 
  xlab = "",
  type = "n"
)

lines(data$DateTimePosixCt, data$Global_active_power)

dev.copy(png, 'plot2.png')
dev.off()
