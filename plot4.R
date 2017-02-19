library(dplyr)

## Read semicolon separated file, set appropriate column classes
df=read.csv("household_power_consumption.txt",sep=";",colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings="?")
df$Date=as.Date(df$Date,"%d/%m/%Y")
## Subset only the dates we care about
df=filter(df,Date>=as.Date("2007/02/01")&Date<=as.Date("2007/02/02"))
## Add a tick column
df$tick=strptime(paste(df$Date, df$Time),"%Y-%m-%d %H:%M:%S")


## Initialize graphics device
png(filename="plot4.png",width=480,height=480)

## Four plot combo
par(mfrow=c(2,2))

# Plot 1
plot(df$tick,df$Global_active_power,ylab="Global Active Power (kilowatts)",type="l",xaxt="n",xlab="")
axis.POSIXct(1,df$tick,format="%a")
# Plot 2
plot(df$tick,df$Voltage,ylab="Voltage",type="l",xaxt="n",xlab="datetime")
axis.POSIXct(1,df$tick,format="%a")
# Plot 3
plot(df$tick,df$Sub_metering_1,ylab="Energy sub metering",type="l",col="black",xaxt="n",xlab="")
points(df$tick,df$Sub_metering_2,type="l",col="red")
points(df$tick,df$Sub_metering_3,type="l",col="blue")
axis.POSIXct(1,df$tick,format="%a")
legend("topright",bty="n",lty=1,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"))
# Plot 4
plot(df$tick,df$Global_reactive_power,ylab="Global_reactive_power",type="l",xaxt="n",xlab="datetime")
axis.POSIXct(1,df$tick,format="%a")

## Close graphics device
dev.off()

