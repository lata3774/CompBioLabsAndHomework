quadratData <- read.csv("Quadrat_plant_community_data.csv", stringsAsFactors = F)

#########################
# The quadrat data file has multiple enteries for each site, I want to combine them into one average per site
quadSites <- read.csv("sites.csv",fileEncoding="UTF-8-BOM",stringsAsFactors = F, na.strings = "")

myMatrix <- matrix(0, ncol = length(names(quadratData)), nrow = length(names(quadSites)))
quadratMeans <- as.data.frame(myMatrix)
colnames(quadratMeans) <- names(quadratData)
quadratMeans$quadrat <- names(quadSites)

for (j in 1:length(quadSites[1,])) {
  sitelogi <- rep(NA, length(quadratData$quadrat))
  for (i in 1:length(quadratData$quadrat)) {
    if (any( quadratData$quadrat[i] == na.omit(quadSites[,j]))) {
      sitelogi[i] <- T
    } else {
      sitelogi[i] <- F
    }
  }
  which(sitelogi)
  
  for ( i in 2:length(quadratMeans[1,])) {
    quadratMeans[j,i] <- mean(quadratData[which(sitelogi),i])
  }
}

# Make a vector of species names to be used later
QuadratSpeciesNames <- sort(names(quadratMeans[2:length(names(quadratMeans))]))

# Check to see if any of the species are not seen at all, then remove them from the data frame
allQuad <- rep(0, length(QuadratSpeciesNames))
for (i in c(1:length(allQuad))) {
  if (length(which(quadratMeans[,i+1] != 0)) == 0) {
    allQuad[i+1] <- 1
  }
}
# This for loop changes the value in allQuad to 1 for each column with all zeros
# Using the allQuad list and which(), I can isolate a list of columns with all zeros
zeroCol <- c(which(allQuad == 1))

# Then remove those columns from the data set
quadratMeans <- quadratMeans[-c(zeroCol)]

# And update the names list
QuadratSpeciesNames <- sort(names(quadratMeans[2:length(names(quadratMeans))]))

# stringr is needed for the nest function
library(stringr)

# A function to import lists of species by Clade from ITIS
cladelist <- function(Clade) {
  # Import the list of species names (per Clade) copied from ITIS and put into a .txt doc
  Clade <- readLines(paste(Clade,".txt", sep = ""))
  # Remove spaces from how the list was formatted when copied
  Clade <- gsub("             ", "", Clade)
  # Make list of genera
  CladeGenus <- word(Clade, 1)
  # Make list of specific epithets
  CladeSpecies <- word(Clade, 2)
  # Combine them with a _
  for (i in 1:(length(Clade))) {
    Clade[i] <- paste(CladeGenus[i], CladeSpecies[i], sep = "_")
  }
  # Make a list of unique genus names (for genus_sp)
  CladeGenusSp <- unique(CladeGenus)
  # Add "_sp" to unique genus names
  for (i in 1:(length(CladeGenusSp))) {
    CladeGenusSp[i] <- paste(CladeGenusSp[i], "sp", sep = "_")
  }
  # Add list of Genus_sp names  to the list
  Clade <- append(Clade, CladeGenusSp)
  Clade <- sort(Clade)
  return(Clade)
}

# Use function to import lists for all families present in list
Magnoliopsida <- cladelist("Magnoliopsida")

# This function creates a data frame of quadrat data for only the chosen Clade
CladeQuadratData <- function(Clade){
  # identify which species names are present on both lists
  CladePresent <- rep(NA, length(Clade))
  for (i in 1:(length(Clade))) {
    if ( any(Clade[i] %in% QuadratSpeciesNames)) {
      CladePresent[i] <- T
    } else {
      CladePresent[i] <- F
    }
  }
  # create a list of column indexes for present species
  CladeColumns <- rep(0,length(Clade[which(CladePresent)]))
  for (i in 1:length(CladeColumns)) {
    CladeColumns[i] <- which(QuadratSpeciesNames == Clade[which(CladePresent)][i])
  }
  # combine the columns into one data frame
  CladeQuadratData <- cbind(quadratMeans[1], quadratMeans[CladeColumns] )
  return(CladeQuadratData)
}


MagnoliopsidaQuadratData <- CladeQuadratData(Magnoliopsida)
# for reasons I cannot begin to comprehend there are two quadrat columns for Magnoliopsida ONLY. I do not understand this at all.
MagnoliopsidaQuadratData <- cbind(MagnoliopsidaQuadratData[1], MagnoliopsidaQuadratData[3:287])

# At this point I realized nearly ALL the data as in Magnoliopsida, and it would be better to subset by Magnioliopsida superorders
Lilianae <- cladelist("Lilianae")
LilianaeQuadratData <- CladeQuadratData(Lilianae)

Rosanae <- cladelist("Rosanae")
RosanaeQuadratData <- CladeQuadratData(Rosanae)

Asteranae <- cladelist("Asteranae")
AsteranaeQuadratData <- CladeQuadratData(Asteranae)

Caryophyllanae <- cladelist("Caryophyllanae")
CaryophyllanaeQuadratData <- CladeQuadratData(Caryophyllanae)

Ranunculanae <- cladelist("Ranunculanae")
RanunculanaeQuadratData <- CladeQuadratData(Ranunculanae)

Magnolianae <- cladelist("Magnolianae")
MagnolianaeQuadratData <- CladeQuadratData(Magnolianae)
# for reasons unknown this is including a random member of Asteranae (QuadratSpeciesName[159] which is not present in the Magnolianae list. I fail to comprehend why this happens

#########################