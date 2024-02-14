# Plot 4

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

# Make Plot 4
	#create png file
	png(file="plot4.png")
	#create the canvas
	par(mfrow=c(2,2))
	
	#top left plot
	#draw plot xaxt = "n" to remove the x axis
	with(data, plot(Time,Global_active_power,xaxt = "n",type = "l",xlab = "",ylab = "Global Active Power (kilowatts)"))
	#add the x axis. at seq defines the 
	axis.POSIXct(1, format = "%a", at = seq(as.POSIXct("2007-02-01"),as.POSIXct("2007-02-03"), "days"))

	#top right plot
	#draw plot xaxt = "n" to remove the x axis
	with(data, plot(Time,Voltage,xaxt = "n",type = "l",xlab = "datetime",))
	#add the x axis. at seq defines the 
	axis.POSIXct(1, format = "%a", at = seq(as.POSIXct("2007-02-01"),as.POSIXct("2007-02-03"), "days"))

	#bottom left plot
	#draw plot xaxt = "n" to remove the x axis.
	#plot sub metering 1
	with(data, plot(Time,Sub_metering_1,xaxt = "n",type = "l",xlab = "",ylab = "Energy sub metering"))
	#plot sub metering 2 
	with(data,lines(Time,Sub_metering_2, col="red"))
	#plot sub metering 3
	with(data,lines(Time,Sub_metering_3, col="blue"))
	#add the x axis. at seq defines the 
	axis.POSIXct(1, format = "%a", at = seq(as.POSIXct("2007-02-01"),as.POSIXct("2007-02-03"), "days"))
	#add legend to plot. bty = n to remove the box around the legend
	legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n", col = c("black","red","blue"), lty =1)
	
	#bottom right plot
	#draw plot xaxt = "n" to remove the x axis
	with(data, plot(Time,Global_reactive_power,xaxt = "n",type = "l",xlab = "datetime",))
	#add the x axis. at seq defines the 
	axis.POSIXct(1, format = "%a", at = seq(as.POSIXct("2007-02-01"),as.POSIXct("2007-02-03"), "days"))

	#close device and save
	dev.off()
