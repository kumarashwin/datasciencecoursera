rankhospital <- function(state, outcome, num = NULL) {
    data <- read.csv("outcome-of-care-measures.csv", header = TRUE, colClasses = "character")
    
    validStates <- unique(data[ ,7])
    validOutcomes <- c("heart attack", "heart failure", "pneumonia")
    #validNums <- c("best", "worst", c)
    
    if(!state %in% validStates)
    {
        stop("invalid state")
    }
    
    if(!outcome %in% validOutcomes)
    {
        stop("invalid outcome")
    }
    
    column <- character()
    switch (outcome,
            "heart attack" = {column <- names(data)[11]},
            "heart failure" = {column <- names(data)[17]},
            "pneumonia" = {column <- names(data)[23]}
    )
    
    stateData <- subset(data, data$State == state, select = c("Hospital.Name", "State", column))
    colnames(stateData)[3] <- "Rate"
    stateData$Rate <- as.numeric(stateData$Rate)
    stateData <- na.omit(stateData)
    stateData <- stateData[order(stateData$Rate, stateData$Hospital.Name), ]
    numberOfRows <- nrow(stateData)
    stateData$Rank <- c(1:numberOfRows)
    
    if(is.null(num)) return(stateData)
    if(num == "best") return(stateData$Hospital.Name[1])
    if(num == "worst") return(stateData$Hospital.Name[numberOfRows])
    
    return(stateData$Hospital.Name[as.numeric(num)])
}