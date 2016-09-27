# Loading useful libraries
library(dplyr)
library(ggplot2)

# Reading Data, assuming working directory is in the folder containing the following rData files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Identify Coal related SCC
motorVehicle <- SCC$SCC[grep("Mobile", SCC$EI.Sector)]

# Select Baltimore motor vehicles elements, group elements by year and summarize them via sum
motorVehicleEmissions <- NEI %>% filter(fips == "24510" & SCC %in% motorVehicle) %>% group_by(year) %>%
    summarize(totalEmissions = sum(Emissions, na.rm = TRUE))

# ggplot2 plots via facets (type), regression line added to display trend
qplot(year, totalEmissions, data = motorVehicleEmissions) + 
    geom_smooth(method = "lm") +
    labs(title = "Plot of PM2.5 Emissions (Tonnes) against year from motor vehicle sources in Baltimore") +
    labs (y = "Total Emissions (Tons)", x = "Year")