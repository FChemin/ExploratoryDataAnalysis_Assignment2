# Download zip file and unzip in directory

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "dataforpeerassessment.zip", method = "curl")
unzip("dataforpeerassessment.zip", exdir = ".")

# Read unziped files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset dataset to isolate vehicle data

VehicleSCC <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
subSCC <- SCC[VehicleSCC,]$SCC

VehicleNEI <- NEI[NEI$SCC %in% subSCC,]
baltimoreVehicle <- subset(VehicleNEI, fips == "24510")

# Plot using ggplot2

png("plot5.png")

ggplot(data = baltimoreVehicle, mapping = aes(factor(year), Emissions)) + 
  geom_bar(stat="identity", fill = "red", width = 0.75) + 
  theme_bw() + guides(fill=FALSE) + 
  labs(x="year", y="Emissions of PM2.5 (in Tons)") + 
  labs(title="Emissions from Vehicles in Baltimore City (1999-2008)")

dev.off()