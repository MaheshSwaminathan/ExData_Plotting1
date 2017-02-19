library(dplyr)

## Read semicolon separated file, set appropriate column classes
df=read.csv("household_power_consumption.txt",sep=";",colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings="?")
df$Date=as.Date(df$Date,"%d/%m/%Y")
## Subset only the dates we care about
df=filter(df,Date>=as.Date("2007/02/01")&Date<=as.Date("2007/02/02"))
## Add a tick column
df$tick=strptime(paste(df$Date, df$Time),"%Y-%m-%d %H:%M:%S")

## Initialize graphics device
png(filename="plot2.png",width=480,height=480)

## Reset layout parameters
par(mfrow=c(1,1))

## Line plot of Global Active Power
plot(df$tick,df$Global_active_power,ylab="Global Active Power (kilowatts)",type="l",xaxt="n",xlab="")
axis.POSIXct(1,df$tick,format="%a")

## Close graphics device
dev.off()
