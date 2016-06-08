complete <- function(directory, id = 1:332)
{
  result <- data.frame()
  
  for(item in id)
  {
    FileLocation <- paste(directory, "\\",                             # E.g. \somedir\
                          formatC(item, width=3, format="d", flag=0),  # 1 -> "001"
                          ".csv", sep="")                              # "001" -> "001.csv"
    
    MonitorData <- read.csv(FileLocation, header = TRUE)
    SulphateDataAvailable <- !is.na(MonitorData[ ,2])
    NitrateDataAvailable  <- !is.na(MonitorData[ ,3])
    CompleteRows <- MonitorData[ SulphateDataAvailable & NitrateDataAvailable, ]
    nobs <- nrow(CompleteRows)
    result <- rbind(result, c( item, nobs ))
  }
  
  result <- setNames(result, c("id","obs"))
  result
}