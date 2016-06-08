corr <- function(directory, threshold = 0, id = 1:332)
{
  result <- numeric()
  
  sulphate<- numeric()
  nitrate<- numeric()
  
  for(item in id)
  {
    fileLocation <- paste(directory, "\\",                             # E.g. \somedir\
                          formatC(item, width=3, format="d", flag=0),  # 1 -> "001"
                          ".csv", sep="")                             # "001" -> "001.csv"
    
    monitorData <- read.csv(fileLocation, header = TRUE)
    sulphateDataAvailable <- !is.na(monitorData[ ,2])
    nitrateDataAvailable  <- !is.na(monitorData[ ,3])
    completeRows <- monitorData[ sulphateDataAvailable & nitrateDataAvailable, ]
    nobs <- nrow(completeRows)
    
    if(nobs > threshold)
    {
      sulphate <- completeRows[ , 2]
      nitrate <- completeRows[ , 3]
      result <- append(result, cor(x=sulphate, y=nitrate, use = "pairwise.complete.obs"))
    }
    
  }
  
  result
}