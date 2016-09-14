# Load ggplot2 library

library(ggplot2)

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

# Data for Baltimore City

BaltimoreVehicles <- subset(VehicleNEI, fips == "24510")
BaltimoreVehicles$city <- "Baltimore City"

# Data for Los Angeles County

LAVehicles  <- subset(VehicleNEI, fips == "06037")
LAVehicles$city <- "Los Angeles County"

# Merge datasets

CompVechicles <- rbind(BaltimoreVehicles, LAVehicles)

# Plot data to compare city

png("plot6.png")

ggplot(data = CompVechicles, mapping = aes(factor(year), Emissions)) + 
  geom_bar(stat="identity", aes(fill=year), width = 0.75) + facet_grid(.~city) +
  theme_bw() + guides(fill=FALSE) + 
  labs(x="year", y="Emissions of PM2.5 (in Tons)") + 
  labs(title="Vehicle Source Emissions of PM2.5 in Baltimore & LA (1999-2008)")

dev.off()