library(dplyr)

## Read semicolon separated file, set appropriate column classes
df=read.csv("household_power_consumption.txt",sep=";",colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings="?")
df$Date=as.Date(df$Date,"%d/%m/%Y")
## Subset only the dates we care about
df=filter(df,Date>=as.Date("2007/02/01")&Date<=as.Date("2007/02/02"))
## Add a tick column
df$tick=strptime(paste(df$Date, df$Time),"%Y-%m-%d %H:%M:%S")


## Initialize graphics device
png(filename="plot3.png",width=480,height=480)

## Reset layout parameters
par(mfrow=c(1,1))

## Energy sub metering plot
plot(df$tick,df$Sub_metering_1,ylab="Energy sub metering",type="l",col="black",xaxt="n",xlab="")
points(df$tick,df$Sub_metering_2,type="l",col="red")
points(df$tick,df$Sub_metering_3,type="l",col="blue")
axis.POSIXct(1,df$tick,format="%a")
legend("topright",lty=1,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"))

## Close graphics device
dev.off()
