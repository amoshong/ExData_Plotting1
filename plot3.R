library(dplyr)
## Read datafrom 2007/2/1 to2007/2/2
tmp=read.table("./R/Data/household_power_consumption.txt",sep=";",header = TRUE,nrows=1)
FirstDT=paste(tmp$Date , tmp$Time,sep=" ");
tmpColNames=names(tmp);
SkipNum<-unclass(strptime("1/2/2007 00:00:00","%d/%m/%Y %H:%M:%S")-strptime(FirstDT,"%d/%m/%Y %H:%M:%S"))*24*60 +1
RowNum<-unclass(strptime("2/2/2007 23:59:00","%d/%m/%Y %H:%M:%S")-strptime("1/2/2007 00:00:00","%d/%m/%Y %H:%M:%S"))*24*60 + 1
PowerData=read.table("./R/data/household_power_consumption.txt",skip=SkipNum,sep=";",header = F,nrows=RowNum,col.names = tmpColNames)
rm(tmp,tmpColNames,FirstDT,SkipNum,RowNum)
#head(PowerData,1)
#tail(PowerData,1)
#print(sapply(PowerData,class))

#convert date time 
PowerData<-mutate(PowerData,DTs=as.POSIXct(strptime(paste(Date ,Time,sep=" "),"%d/%m/%Y %H:%M:%S")))

# chinese os to english LC_Time
Sys.setlocale("LC_TIME", "English")

# plot 3
png(filename = "./R/Fig/plot3.png")

with(PowerData,{
    plot(DTs,Sub_metering_1,xlab="",ylab="Energy sub metering",type="n")
    lines(DTs,Sub_metering_1)
    lines(DTs,Sub_metering_2,col="red")
    lines(DTs,Sub_metering_3,col="blue")
})
legend("topright",lty=1, col = c("black","red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
