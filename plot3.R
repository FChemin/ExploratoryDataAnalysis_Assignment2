# Load ggplot2 library

library(ggplot2)

# Download zip file and unzip in directory

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "dataforpeerassessment.zip", method = "curl")
unzip("dataforpeerassessment.zip", exdir = ".")

# Read unziped files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset dataset to isolate Baltimore City data

baltimore <- subset(NEI, fips == "24510")

# Plot using ggplot2

png("plot3.png")

ggplot(data = baltimore, mapping = aes(factor(year), Emissions, fill=type)) + 
  facet_grid(.~type) + geom_bar(stat="identity") + 
  labs(x="year", y="Total Emissions of PM2.5") + 
  labs(title="Emissions of PM2.5 in Baltimore City by Source Type")

dev.off()