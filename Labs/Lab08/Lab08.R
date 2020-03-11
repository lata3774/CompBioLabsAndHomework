# Lab08
# Lauren Taylor
# March 6, 2020

# 3. a-c:
# Population abundance over time
# r = intrinsic growth rate, K = carrying capacity
# generations = total number of generations, nStart = initial population size
logisticGrowthModel <- function ( r, K, generations, nStart ) {
  #create vector to store results in
  abundance <- c(1:generations)
  #set first point in vector as nStart (initial population size)
  abundance[1] <- nStart
  #generate population abundance over time for generation 2 onwards following equation n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )
  for (i in 2:generations) {
    abundance[i] <- abundance[i-1] + ( r * abundance[i-1] * (K - abundance[i-1])/K )
  }
  #create vector to list generations
  generations <- c(1:generations)
  #plot abundance by generation
  plot ( generations, abundance, xlab = "Generations", ylab = "Abundance" )
  #create a matrix with generations and abundance vectors
  logisticMatrix <- cbind(generations, abundance)
  return(logisticMatrix)
}

# 3. d:
# call function
logisticModel <- logisticGrowthModel( .7, 10000, 20, 120 )

# 3. e:
# write function output into a .csv file
write.csv( x = logisticModel, file = "Lab08Data.csv", row.names = FALSE)
