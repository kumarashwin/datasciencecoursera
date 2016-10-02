plot2 <- function(data=NULL){
    if(is.null(data)){
        # First step is to read the data in the fastest way possible:
        # We will read the first row to determine the column classes;
        tab5rows <- read.table("./household_power_consumption.txt", sep=";",
                               header = TRUE, nrows = 1, stringsAsFactors = FALSE, na.strings = "?")
        classes <- sapply(tab5rows[1, ], class)
        
        #We already know the number of rows as 2,075,259, therefore:
        data <- read.table("./household_power_consumption.txt",
                           sep = ";", header = TRUE, colClasses = classes,
                           nrows = 2075259, stringsAsFactors = FALSE, na.strings = "?")
    }
    
    #The two dates for which we will extract the data from the main dataset
    dates <- c("1/2/2007", "2/2/2007")
    
    # We subset only those rows whose Date values thus match:
    data <- subset(data, Date %in% dates)
    
    #Should give us 2880 observations...
    
    # We will use strptime to add a column that contains the exact date
    # and time for each observation so that we can work on it easier for the plots
    #
    # First we combine the two into a single string:
    dateTime <- with(data, paste(Date, Time))
    
    # Now we add the column:
    data$DateTime <- strptime(dateTime, format="%d/%m/%Y %H:%M:%S")
    
    #And plot to the png file:
    png("plot2.png")
    plot(data$DateTime, data$Global_active_power,
         type = "l", xlab = "", ylab="Global Active Power (kilowatts)")
    dev.off()
}