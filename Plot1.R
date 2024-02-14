# Plot 1

# Get the data
	# Define URL and files to save the data in
	dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	zipfilename <- "powerdata.zip"
	filename <- "powerdata"

	# Download the data
	download.file(dataURL, zipfilename)

	# Unzip the data
	unzip(zipfilename, exdir = filename)

# Read the data
	
	# Create variable containing the file name
	datafile <- "powerdata/household_power_consumption.txt"
	
	# Create variable containing the data
	data <- read.csv(datafile,sep=";")

# Converting the dates and times
	# Load dplyr
	library("dplyr")
	# Mutate Time and Date Columns to make a new date stamp column then filter for the needed dates
	data <- data %>%
			mutate(Time = paste(Date, Time)) %>%
			mutate(Time = strptime(Time, format = "%d/%m/%Y %H:%M:%S")) %>%
			mutate(Date = as.Date(Date, "%d/%m/%Y")) %>%
			filter(Date == "2007-02-02" | Date == "2007-02-01") 

# Make Plot 1
	#create png file
	png(file="plot1.png")
	#draw plot
	with(data, hist(as.numeric(Global_active_power), xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col ="red"))
	dev.off()
