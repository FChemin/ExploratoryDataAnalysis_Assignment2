# Download zip file and unzip in directory

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "dataforpeerassessment.zip", method = "curl")
unzip("dataforpeerassessment.zip", exdir = ".")

# Read unziped files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset to isolate data for Baltimore

baltimore <- subset(NEI, fips == "24510")
PM25Baltimore <- tapply(baltimore$Emissions, baltimore$year, mean)

# Plot total emissions of PM2.5 and save to png file

png("plot2.png")
plot(PM25Baltimore, main = "Total Emissions from PM2.5 in Baltimore", xlab = "Years", xaxt = "n")
lines(PM25Baltimore, col = "red")
axis(side = 1, at = seq(1,4,1), labels = c("1999", "2002", "2005", "2008"))
dev.off()