# Lab 11
# Lauren Taylor

GlobalWoodDensityData <- read.csv("GlobalWoodDensityDatabase.csv", stringsAsFactors = F)
colnames(GlobalWoodDensityData)[4] <- "WoodDensity"
# Note that the wood density is in g/cm^3, oven dry mass/fresh volume.

# Part II: Working with density data
# 4. Removing rows with missing data
# 4a. Which row is missing data?
RowNA <- GlobalWoodDensityData$Number[which(is.na(GlobalWoodDensityData$WoodDensity))]
# 4b. Remove row with missing data
GlobalWoodDensityData <- GlobalWoodDensityData[ !(GlobalWoodDensityData$Number %in% RowNA),]

# 5. Create data frame with each species only listed once
SpeciesMeanDensity <- GlobalWoodDensityData %>% group_by(Binomial,Family) %>% summarise(MeanDensity = mean(WoodDensity))

# 6. Contrasting most and least dense families
# 6a. Make a new data frame of average density for each Family
FamilyMeanDensity <- SpeciesMeanDensity %>% group_by(Family) %>% summarise(MeanDensity = mean(MeanDensity))

# 6b. Sort the result of problem 6a by MeanDensity
FamilyMeanDensity <- arrange(FamilyMeanDensity, MeanDensity)

# 6c. 8 highest and lowest avg. density families:
numberFamilies <- 8
LowAvgFamilies <- head(FamilyMeanDensity$Family,numberFamilies)
HighAvgFamilies <- tail(FamilyMeanDensity$Family,numberFamilies)

HighAvgFamAll <- GlobalWoodDensityData[(GlobalWoodDensityData$Family %in% HighAvgFamilies),]
LowAvgFamAll <- GlobalWoodDensityData[(GlobalWoodDensityData$Family %in% LowAvgFamilies),]