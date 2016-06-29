rankall <- function(outcome, num = "best"){
    data <- read.csv("outcome-of-care-measures.csv", header = TRUE, colClasses = "character")
    
    validOutcomes <- c("heart attack", "heart failure", "pneumonia")
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
    
    result <- subset(data, select = c("Hospital.Name", "State", column))
    colnames(result)[3] <- "Rate"
    result$Rate <- as.numeric(result$Rate)
    result <- na.omit(result)
    result <- result[order(result$State, result$Rate, result$Hospital.Name), ]
    
    rankArray <- tapply(result$Rate,result$State,
                    function(i){
                        return(rank(i, ties.method = "first"))})
    
    Rank <- numeric()
    for(i in 1:length(rankArray))
    {
        Rank <- c(Rank,rankArray[[i]])
    }
    
    result <- cbind(result, Rank)
    
    #Cleanup
    rm(column)
    rm(validOutcomes)
    rm(i)
    rm(Rank)
    rm(rankArray)
    
    if(num == "best") return(subset(result,
                                    result$Rank == 1,
                                    select = c("Hospital.Name","State")))
    if(num == "worst") {
        final <- data.frame()
        #names(final) = c("Hospital","State")
        
        worstRanksByState <- tapply(result$Rank,result$State,max)
        states <- names(worstRanksByState)
        
        for(state in states){
            currentState <- subset(result,
                                   result$State == state & result$Rank == worstRanksByState[state][[1]],
                                   select = c("Hospital.Name","State"))
            final <- rbind(final, currentState)
        }
        return(final)
    }
    
    return(subset(result, result$Rank == num, select = c("Hospital.Name","State")))
}