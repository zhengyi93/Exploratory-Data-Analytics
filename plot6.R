# Loading useful libraries
library(dplyr)

# Reading Data, assuming working directory is in the folder containing the following rData files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Identify Coal related SCC
motorVehicle <- SCC$SCC[grep("Mobile", SCC$EI.Sector)]

# Select Baltimore motor vehicles elements, group elements by year and summarize them via sum
Baltimore <- NEI %>% filter(fips == "24510" & SCC %in% motorVehicle) %>% 
    group_by(year, fips) %>%
    summarize(totalEmissions = sum(Emissions, na.rm = TRUE))

# Select LA motor vehicles elements, group elements by year and summarize them via sum
LA <- NEI %>% filter(fips == "06037" & SCC %in% motorVehicle) %>% 
    group_by(year, fips) %>%
    summarize(totalEmissions = sum(Emissions, na.rm = TRUE))

# Plotting Note: y-axis of both plots are scaled to have 3000 Tonnes difference between extremes
# Multiple plot + margin scaling
par(mfrow = c(1, 2), mar = c(5, 5, 4, 2), oma = c(0, 0, 2, 0))

# Scatter plot for Baltimore City
with(Baltimore, plot(year, totalEmissions,
                         main = "Baltimore City",
                         xlab = "Year", ylab = "Total PM2.5 Emission (Tonnes)",
                         ylim = c(-1000, 2000), xaxt = "n", pch = 4))

# Relabel axis into a readable form
axis(1, at=c(1999, 2002, 2005, 2008))

# Display regression line in red
model <- lm(totalEmissions ~ year, Baltimore)
abline(model, lwd = 2, col = "red")

# Scatter plot for Baltimore City
with(LA, plot(year, totalEmissions,
                         main = "Los Angeles County",
                         xlab = "Year", ylab = "Total PM2.5 Emission (Tonnes)",
                         ylim = c(8000, 11000), xaxt = "n", pch = 4))

# Relabel axis into a readable form
axis(1, at=c(1999, 2002, 2005, 2008))

# Display regression line in red
model <- lm(totalEmissions ~ year, LA)
abline(model, lwd = 2, col = "red")

# Add an overall title
title(main = "Plot of PM2.5 Emissions (Tonnes) against year from motor vehicle sources", outer = TRUE)