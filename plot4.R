#Loading Datataset
if(!file.exists("./data/household_power_consumption_tidy.txt")){
  print("generating Tidy data set from house_hold_power_consumption.txt")
  #Checking if raw data is in table
  if(!file.exists("./data/household_power_consumption.txt")){
    stop("Need to donwload and unzip raw data set into data folder. See README.md")
  }else{
    #loading dataset using data table
    rawDS <- read.table(file="./data/household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
    #Converting Date Column to Date
    rawDS$Date = as.Date(rawDS$Date,"%d/%m/%Y")
    #Filtering Dataset to date 2007-02-01 and 2007-02-02
    tidyDS <- rbind(rawDS[rawDS[,1]==as.Date("2007-02-01"),],rawDS[rawDS[,1]==as.Date("2007-02-02"),])
    #Wrting TidyDataSet to Smaller Sample File.
    write.table(tidyDS, file = "./data/household_power_consumption_tidy.txt",row.names=FALSE);
    print("Finished generating Tidy DataSet and written to file!")
    #Removing so unnecesary file memory comsumption.
    rm(rawDS);
  }
}else{
  print("Reading From Tidy Data Set file")
  tidyDS <- read.table(file="./data/household_power_consumption_tidy.txt", header = TRUE)
}
#Setting Date Column to Date
tidyDS$Date = as.Date(tidyDS$Date)
#Setting Time Column to DateTime
tidyDS$Time<-strptime( paste( format(tidyDS$Date,"%Y/%m/%d") , tidyDS$Time),format="%Y/%m/%d %H:%M:%S")
#Preparing Device
png(file="plot4.png", width=480, height=480, bg="transparent")
#setting for 2 by 2 plots, margin and outer margin
par(mfcol = c(2,2),mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
#top left plot
plot(tidyDS$Time, tidyDS$Global_active_power, type="l", ylab="Global Active Power", xlab="")
#bottom left plot
plot(tidyDS$Time, tidyDS$Sub_metering_1, type="l", ylab="Energy Sub Metering", xlab="", col="black")
lines(tidyDS$Time, tidyDS$Sub_metering_2, type="l", col="red")
lines(tidyDS$Time, tidyDS$Sub_metering_3, type="l", col="blue")
#Using bty to n so border won't show in legends
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1,bty="n")
#top right plot
plot(tidyDS$Time, tidyDS$Voltage, type="l",ylab="Voltage", xlab="datetime")
#bottom right plot
plot(tidyDS$Time, tidyDS$Global_reactive_power, type="l",ylab="Global_reactive_power", xlab="datetime")
dev.off() 
