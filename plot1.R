
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

# plot 1

png(filename = "./R/Fig/plot1.png")
hist(PowerData$Global_active_power,main="Global Active Power",xlab="Global Active Power (kiliowatts)",col="red")
dev.off()
