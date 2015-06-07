list.of.packages <- c("sqldf")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

file <- c("household_power_consumption.txt");
data <- read.csv.sql(file, "select * from file where Date in ('1/2/2007','2/2/2007')", header=T, sep=';')

data$Date <- as.Date(strptime(data$Date, format='%d/%m/%Y'))

hist(
  data$Global_active_power, 
  col=c("red"), 
  main="Global Active Power", 
  xlab="Global Active Power (kilowatts)"
)

dev.copy(png, 'plot1.png')
dev.off()