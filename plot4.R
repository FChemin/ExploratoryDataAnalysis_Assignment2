# Load ggplot2 library

library(ggplot2)

# Download zip file and unzip in directory

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "dataforpeerassessment.zip", method = "curl")
unzip("dataforpeerassessment.zip", exdir = ".")

# Read unziped files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset dataset to isolate coal combustion data

combSCC <- grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE)
coalSCC <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)
combcoalSCC <- (combSCC & coalSCC)
subSCC <- SCC[combcoalSCC,]$SCC

combcoalNEI <- NEI[NEI$SCC %in% subSCC,]

# Plot using ggplot2

png("plot4.png")

ggplot(data = combcoalNEI, mapping = aes(factor(year), Emissions/10^5)) + 
  geom_bar(stat="identity", fill = "blue", width = 0.75) + 
  theme_bw() +
  labs(x="year", y="Coal Related Emissions of PM2.5 (in Tons)") + 
  labs(title="Coal Combustion-related Emissions across United States (1999-2008)")

dev.off()