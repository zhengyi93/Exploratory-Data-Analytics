# Loading useful libraries
library(dplyr)

# Reading Data, assuming working directory is in the folder containing the following rData files
NEI <- readRDS("summarySCC_PM25.rds")

# Group elements by year and summarize them via sum
totalEmissions <- NEI %>% group_by(year) %>% summarize(totalEmissions = sum(Emissions, na.rm = TRUE))

# Slightly adjust left margin
par(mar = c(5, 6, 4, 2))

# Scatter plot
with(totalEmissions, plot(year, totalEmissions,
                          main = "Plot of Total PM2.5 Emission (Megatons) against Year",
                          xlab = "Year", ylab = "Total PM2.5 Emission (Megatons)",
                          xaxt = "n", yaxt = "n",
                          pch = 4))

# Relabel axis into a readable form
axis(1, at=c(1999, 2002, 2005, 2008))
axis(2, at=c(4e6, 5e6, 6e6, 7e6), labels = c(4, 5, 6, 7))

# Display regression line in red
model <- lm(totalEmissions ~ year, totalEmissions)
abline(model, lwd = 2, col = "red")