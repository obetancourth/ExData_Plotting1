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
    #Changing Time Column to Time
    #Converting Time Column to Time
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
#Setting Time Column to Column
tidyDS$Time<-strptime(tidyDS$Time,format="%H:%M:%S")