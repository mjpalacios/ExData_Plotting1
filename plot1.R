#Project 1

##Plot 1
plot1 <- function() { 
  ### 1. Read Raw Data
  if (!file.exists("household_power_consumption.zip")) {
    rc <-
      download.file(
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
        "household_power_consumption.zip"
      )
    if (rc != 0) {
      stop("Couldn't download household power consumption data from the Internet")
    }
  }
  conn <- unz("household_power_consumption.zip", "household_power_consumption.txt")
  hpc.raw <-
    read.csv(
      conn, header = TRUE, sep = ";", colClasses =
        c("character", "character", rep("numeric", 7)), comment.char = "", na.strings = "?"
    )
  closeAllConnections()
  
  ### 2. Convert first column (Date) from character to Date
  hpc.raw$Date <- as.Date(hpc.raw$Date, "%d/%m/%Y")
  
  ### 3. Subset Data to range of interest 2007-02-01 2007-02-02
  hpc.sub <-
    hpc.raw[hpc.raw$Date >= "2007-02-01" &
              hpc.raw$Date <= "2007-02-02",]
  
  ### 4. Convert second column (Time) from character to POSIXlt
  hpc.sub$Time <-
    strptime(paste(hpc.sub$Date, hpc.sub$Time), "%Y-%m-%d %H:%M:%S")
  
  ### 5. Plot
  p2main <- "Global Active Power"
  p2xlab <- "Global Active Power (kilowatts)"
  png(file = "plot1.png")
  hist(
    hpc.sub$Global_active_power, col = "red", main = p2main, xlab = p2xlab
  )
  dev.off()
  return (0)
}

## To use:
###source("plot1.R")
###plot1()
## That will create the "plot1.png" file.