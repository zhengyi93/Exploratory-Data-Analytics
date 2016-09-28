# Loading useful libraries
library(dplyr)

# Reading Data, assuming working directory is in the folder containing the following rData files
NEI <- readRDS("summarySCC_PM25.rds")

# Select Baltimore City elements, group elements by year and summarize them via sum
BaltimoreCity <- NEI %>% filter(fips == "24510") %>% group_by(year) %>%
    summarize(totalEmissions = sum(Emissions, na.rm = TRUE))

# Plot 2
png("plot2.png")


# Slightly adjust left margin
par(mar = c(5, 6, 4, 2))

# Scatter plot
with(BaltimoreCity, plot(year, totalEmissions,
                          main = "Plot of Total PM2.5 Emission (Tonnes) against Year in Baltimore",
                          xlab = "Year", ylab = "Total PM2.5 Emission (Tonnes)",
                          xaxt = "n", pch = 4))

# Relabel axis into a readable form
axis(1, at=c(1999, 2002, 2005, 2008))

# Display regression line in red
model <- lm(totalEmissions ~ year, BaltimoreCity)
abline(model, lwd = 2, col = "red")

dev.off()