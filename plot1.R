# Download zip file and unzip in directory

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "dataforpeerassessment.zip", method = "curl")
unzip("dataforpeerassessment.zip", exdir = ".")

# Read unziped files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Compute total emissions from all sources by year

PM25Totals <- tapply(NEI$Emissions, NEI$year, mean)

# Plot total emissions of PM2.5 and save to png file

png("plot1.png")
plot(PM25Totals, main = "Total Emissions from PM2.5", xlab = "Years", xaxt = "n")
lines(PM25Totals, col = "red")
axis(side = 1, at = seq(1,4,1), labels = c("1999", "2002", "2005", "2008"))
dev.off()