# Tallgrass Prairie Restoration Diversity
## Introduction
The data set I will be working with for this project comes from tallgrass prairie restoration sites from the Midwest.  I chose this data set specifically because it's large (300 species and 1000 surveyed sites) and because I've participated in prairie restoration, growing up in Illinois.  Only 4% of tallgrass prairie land remains in North America, making its restoration efforts difficult, as many of the original prairies are no longer around to model restorations after.  My goal for this project is to create graphs illustrating diversity at different taxonomic levels at these sites.
## Summary of Data to be Analyzed
### Goals of the original study that produced the data
The goal of the original data set was to identify patterns of diversity among different restored grassland environments.  The patterns would be informative to predict the outcomes of prairie restoration in the future, particularly what kinds of environmental features are associated with high phylogenetic diversity.  This study takes datasets from Illinois, Indiana, and Michigan prairie restoration sites.
### Brief description of methodology that produced the data
The data was produced by quadrat sampling at four different grassland restoration sites.  For the Nachusa Grasslands dataset, ten points on a 25 point grid were randomly selected and the proportional cover of live plant species, litter, and bare ground at each point were recorded.  This data set contains surveys from 2017 and 2018.

The data from three other restorations was collected with a smaller quadrat than the Nachusa Grasslands, but the same method was used otherwise.  For this reason, though, the Nachusa Grasslands diversity should not be compared to the McHenry County, Kankakee Sands, and Michigan sites. 
### Type of data in this data set:
The data set contains two different .csv files: one of site environmental data, and one of quadrat survey data.  The environmental data set is 19 KB and contains unique site codes along with a set of environmental conditions, including pH, most recent prescribed burn, and the year of the site's first growing season.  The quadrat survey data is 714 KB and contains site codes correlating to those from the environmental data, and a large matrix of counts for each species (over 300 total) per each quadrat (over 1000 total).

## Detailed Description of Analysis to be done and Challenges Involved
The first thing I need to do with the data set is remove species that are not actually found in any of the surveys - they just take up unnecessary space and skew my estimate of the number of species I will be working with.  My next step after that will be to sort the data by taxonomic levels.  To get data on taxonomic levels and not have to go through and find all the species myself, I will use lists generated from [ITIS](https://www.itis.gov/).  For example, for the order Malpighiales, I can generate a list of the 171 accepted genera, or 4138 accepted species.  The lists will need to be modified before they are usable.  I also plan to separate the data by the four original data sets.  The quatrat sample names are formatted as the site name with a suffix, so I will have to determine a way to modify the quadrat names so they can be used to organize the data.  In addition with attempting to reproduce the original study's analysis of phylogenetic and taxonomic diversity, I plan to make graphs, using ggplot, of diversity at different taxonomic levels.

## References
[Barber, Nicholas A., et al. “Grassland Restoration Characteristics Influence Phylogenetic and Taxonomic Structure of Plant Communities and Suggest Assembly Mechanisms.” _Journal of Ecology_, vol. 107, no. 5, 2019, pp. 2105–2120., doi:10.1111/1365-2745.13250.](https://besjournals-onlinelibrary-wiley-com.colorado.idm.oclc.org/doi/full/10.1111/1365-2745.13250)

[Integrated Taxonomic Information System](https://www.itis.gov/)

[Tallgrass Prairie National Preserve, Kansas](https://www.nps.gov/tapr/index.htm)

