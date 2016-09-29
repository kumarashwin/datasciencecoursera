# PLACE THIS FILE IN THE SAME FOLDER AS 'UCI HAR Dataset'
# AND MAKE SURE TO SET THAT FOLDER AS YOUR WORKING DIRECTORY

#Title: run_analysis.R
#Author: Ash Kumar (https://github.com/kumarashwin/)
#Date: September 29, 2016

# The following function reads data collected from the UCI HAR Dataset
# and assembles a tidy dataset that is then returned to the caller of
# the function.
runAnalysis <- function(){
    
    #--- test ---
    testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                               stringsAsFactors = FALSE,
                               col.names = "Subject")
    testActivities <- read.table("./UCI HAR Dataset/test/y_test.txt",
                                 stringsAsFactors = FALSE,
                                 col.names = "Activity")
    testReadings <- read.table("./UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)
    
    fieldNames <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
    fieldNames <- fieldNames[[2]]
    colnames(testReadings) <- fieldNames
    
    finalTest <- cbind(testSubjects, testActivities, testReadings)
    
    #--- train ---
    trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                               stringsAsFactors = FALSE,
                               col.names = "Subject")
    trainActivities <- read.table("./UCI HAR Dataset/train/y_train.txt",
                                 stringsAsFactors = FALSE,
                                 col.names = "Activity")
    trainReadings <- read.table("./UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
    colnames(trainReadings) <- fieldNames
    finalTrain <- cbind(trainSubjects, trainActivities, trainReadings)
    
    #--- uniting the two data frames ---
    finalData <- rbind(finalTest, finalTrain)
    
    #--- subsetting to result in only those columns that are requested ---
    colsToSubset <- c(1:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, 255:256, 268:273, 347:352, 426:431, 505:506, 518:519, 531:532, 544:545)
    subsettedData <- finalData[colsToSubset]
    
    #--- fetching activity names ---
    activityNames <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
    activityNames <- activityNames[[2]]
    
    #--- replacing activity numbers with descriptions ---
    numberOfRows <- nrow(subsettedData)
    for(i in 1:numberOfRows){
        activity <- activityNames[as.numeric(subsettedData$Activity[i])]
        subsettedData$Activity[i] <- activity
    }
    
    #--- calculating means
    first = TRUE
    for(i in 1:30){
        currentSubjectData <- subset(subsettedData, subsettedData$Subject == i)
        dataByActivity <- aggregate(currentSubjectData[ ,c(1,3:68)],
                                    by=list(currentSubjectData$Activity),
                                    mean)
        if(first){
            finalData = dataByActivity
            first = FALSE
        }
        else{
            finalData = rbind(finalData, dataByActivity)
        }
    }
    
    #--- fixing column names and position ---
    colnames(finalData)[1] <- "Activity"
    finalData <- finalData[ ,c(2,1,3:68)]
    
    #--- end ---
    write.csv(finalData, file="tidyData.csv")
    return(finalData)
}