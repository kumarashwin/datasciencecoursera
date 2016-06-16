pollutantmean <- function(directory, pollutant, id = 1:332)
{
  Mean <- numeric()
  AllReadings <- numeric()
  
  id <- formatC(id, width=3, format="d", flag=0)
  id <- paste(id, "csv", sep=".")
  
  CollectReadings <- function(pollutant, MonitorData)
  {
    NAsinReadings <- is.na(MonitorData[ , pollutant])
    ReadingsNAsRemoved <- MonitorData[ , pollutant][!NAsinReadings]
  }
  
  for(item in id)
  {
    FileLocation <- paste(directory, item, sep="\\")
    CurrentMonitorData <- read.csv(FileLocation, header = TRUE)
    
    CurrentReadings <- CollectReadings(switch(pollutant, "sulphate" = 2, "nitrate"= 3), CurrentMonitorData) 
    
    AllReadings <- append(AllReadings, CurrentReadings)
  }
  
  mean(AllReadings)
}