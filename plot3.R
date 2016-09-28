# Loading useful libraries
library(dplyr)
library(ggplot2)

# Reading Data, assuming working directory is in the folder containing the following rData files
NEI <- readRDS("summarySCC_PM25.rds")

# Select Baltimore City elements, group elements by year, type and summarize them via sum
BaltimoreCity <- NEI %>% filter(fips == "24510") %>% group_by(year, type) %>%
    summarize(totalEmissions = sum(Emissions, na.rm = TRUE))

# Plot 3
png("plot3.png")

# ggplot2 plots via facets (type), regression line added to display trend
qplot(year, totalEmissions, data = BaltimoreCity, facets = . ~ type) + 
    geom_smooth(method = "lm") +
    labs(title = "Plot of PM2.5 Emissions (Tonnes) against year for each type in Baltimore") +
    labs (y = "Total Emissions (Tons)", x = "Year")

dev.off()