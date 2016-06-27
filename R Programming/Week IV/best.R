best <- function(state, outcome) {
    data <- read.csv("outcome-of-care-measures.csv", header = TRUE, colClasses = "character")
    
    validStates <- unique(data[ ,7])
    validOutcomes <- c("heart attack", "heart failure", "pneumonia")
    
    if(!state %in% validStates)
    {
        stop("invalid state")
    }
    
    if(!outcome %in% validOutcomes)
    {
        stop("invalid outcome")
    }
    
    column <- as.character()
    
    switch (outcome,
        "heart attack" = {column <- "heartAttack"},
        "heart failure" = {column <- "heartFailure"},
        "pneumonia" = {column <- "pneumonia"}
    )
    
    refinedData <- data.frame(hospitalName = data[ ,2],
                              stateName = data[,7],
                              heartAttack = as.numeric(data[,11]),
                              heartFailure = as.numeric(data[,17]),
                              pneumonia = as.numeric(data[,23]),
                              stringsAsFactors = FALSE)
    
    stateData <- subset(refinedData, stateName == state, select = c("hospitalName",column ))
    
    finalData <- na.omit(stateData)
    result <- finalData[finalData[ ,2] == min(finalData[ ,2]), ]
    if(nrow(result) > 1)
    {
        return(result[order(result$hospitalName),]$hospitalName[1])
    }
    return(result$hospitalName)
}