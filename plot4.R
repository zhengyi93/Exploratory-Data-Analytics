# Loading useful libraries
library(dplyr)
library(ggplot2)

# Reading Data, assuming working directory is in the folder containing the following rData files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Identify Coal related SCC
Coal <- SCC$SCC[grep("Coal", SCC$EI.Sector)]

# Select Coal elements, group elements by year and summarize them via sum
CoalEmissions <- NEI %>% filter(SCC %in% Coal) %>% group_by(year) %>%
    summarize(totalEmissions = sum(Emissions, na.rm = TRUE))

# ggplot2 plots via facets (type), regression line added to display trend
qplot(year, totalEmissions, data = CoalEmissions) + 
    geom_smooth(method = "lm") +
    labs(title = "Plot of PM2.5 Emissions (Tonnes) against year from coal combustion-related source") +
    labs (y = "Total Emissions (Tons)", x = "Year")