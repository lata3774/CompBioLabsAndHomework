# Part I. Practice some simple conditionals.

# 1: Create a variable named x and assign a numeric value of your choosing to it. On the next line of code, write an if-else statement that checks if the value is larger than 5. Your code should print a message about whether the value is larger or smaller than 5.
x <- 21
if ( x > 5 ) {
  print("Value greater than 5")
} else {
  print("Value less than 5")
}

# 2: import ExampleData.csv file
ExampleData <- read.csv("ExampleData.csv")
# change data frame to vector to make things simpler
ExDataVec <- ExampleData$x

# 2a: Using a for() loop, write code that checks each value in the imported data and changes every negative value to be NA. Note: NA is an actual value in R that acts as a placeholder and/or signifies that data are missing/absent/not-applicable for a particular position in a data object.
for (i in 1:length(ExDataVec)) {
  if ( ExDataVec[i] < 0 ) {
    ExDataVec[i] <- NA
  }
}

# 2b: Using vectorized code (no loop) that makes use of "logical" indexing, change all those NA values with NaN. Note that NaN is a numeric value meaning "not a number". Also note that R has a function, is.na(), for testing if something is an NA. You can NOT use == on NA values or NaN values.
# is.na returns TRUE for every NA, <- changes only TRUE values to NaN
ExDataVec[ is.na(ExDataVec) ] <- NaN 

# 2c: Using a which() statement and integer indexing (again, no loop), change all those NaN values with a zero. Note that R has a function, is.nan(), for testing if something is an NaN. You can NOT use == on NA values or NaN values.
# is.nan returns a TRUE for every NaN, which returns a vector of index positions of each TRUE, then <- changes each index position value to 0
ExDataVec[ which( is.nan( ExDataVec))] <- 0

# 2d: Use code to determine how many of the values from the imported data fall in the range between 50 and 100 (inclusive of those endpoints).
# vectorized logical argument finds values between (inclusive) 50 and 100, which creates a list of only TRUE values, and length returns a total of the TRUEs by returning the length of the which vector
length(which(ExDataVec >= 50 & ExDataVec <= 100))

# 2e: Using any method of your choice, create a new vector of data that has all the values from the imported data that fall in the range between 50 and 100. Do NOT dynamically grow the array, however. This vector should be named "FiftyToOneHundred".
#myvec[logical argument] creates a vector of TRUE values in vector
FiftyToOneHundred <- ExDataVec[ ExDataVec >= 50 & ExDataVec <= 100 ]

# 2f: Use write.csv() to save your vector to a file named "FiftyToOneHundred.csv". Please use all default settings with write.csv(). In other words, assuming that your current working directory is your own directory for your work for Lab05, save it with the command write.csv(x = FiftyToOneHundred, file = "FiftyToOneHundred.csv")
write.csv(x = FiftyToOneHundred, file = "FiftyToOneHundred.csv")

#3 Import the data on CO2 emissions from last week's lab ("CO2_data_cut_paste.csv" from Lab04). Read the accompanying metadata (in a plain text file in the same directory) to learn what the data represent.
CO2Data <- read.csv("CO2_data_cut_paste.csv")

# 3a: What was the first year for which data on "Gas" emissions were non-zero?
#which filters out nonzero values, then [1] returns the vector of the first result, then CO2Data$Year[vector] returns the year value
CO2Data$Year[which(CO2Data$Gas != 0)[1]]

# 3b: During which years were "Total" emissions between 200 and 300 million metric tons of carbon?
#same as above, but with an AND and no need to specify only the first result
CO2Data$Year[which(CO2Data$Total > 200 & CO2Data$Total < 300)]

# Part II. Loops + conditionals + biology

# Lotka-Volterra predator-prey model
# n[t] is abundance of prey at time t
# p[t] is abundance of predators at time t
# m is intrinsic mortality rate
# k is conversion constant of consumed prey into biomass of predators
# r is intrinsic growth rate
# a is attack rate
# n[t] <- n[t-1] + (r * n[t-1]) - (a * n[t-1] * p[t-1])
# p[t] <- p[t-1] + (k * a * n[t-1] * p[t-1]) - (m * p[t-1])

#parameter values
totalGenerations <- 1000
initPrey <- 100 	# initial prey abundance at time t = 1
initPred <- 10		# initial predator abundance at time t = 1
a <- 0.01 		# attack rate
r <- 0.2 		# growth rate of prey
m <- 0.05 		# mortality rate of predators
k <- 0.1 		# conversion constant of prey into predators

#time vector, vectors for n and p over time
time <- c(2:totalGenerations)
n <- c(1:totalGenerations)
p <- c(1:totalGenerations)

n[1] <- initPrey
p[1] <- initPred
for (i in time) {
  n[i] <- n[i-1] + (r * n[i-1]) - (a * n[i-1] * p[i-1])
  if (n[i] < 0) {
    n[i] <- 0
  }
  p[i] <- p[i-1] + (k * a * n[i-1] * p[i-1]) - (m * p[i-1])
}

#plot: start with plotting prey, with title and axes lables
plot(c(1:totalGenerations),n, type = "l", main = "Predator and Prey Abundances over Time", xlab = "Generations", ylab = "Population Size")
#add line for predators, color it red and make it a dashed line so it doesn't cover prey line when both are equal to 0
lines(c(1:totalGenerations),p, col = "red", lty = 2)
#add legend to top right of plot, labled for prey/predators, colored and dashed same as lines in plot
legend("topright", legend = c("Prey","Predators"), col = c("black","red"), lty = 1:2)

myResults <- cbind(c(1:totalGenerations), n, p)
colnames(myResults)[1:3] <- c("TimeStep", "PreyAbundance", "PredatorAbundance")
write.csv(x = myResults, file = "PredPreyResults.csv")

#Part III:
initPreyVec <- seq(from = 10, to = 100, by = 10)

#to store the data, we need two matrices: one for prey, one for predators
nMatrix <- matrix(nrow = totalGenerations, ncol = length(initPreyVec))
colnames(nMatrix) <- initPreyVec #columns are named by init prey number
pMatrix <- matrix(nrow = totalGenerations, ncol = length(initPreyVec))
colnames(pMatrix) <- initPreyVec #columns are named by init prey number

#set initial values
nMatrix[1,] <- initPreyVec
pMatrix[1,] <- initPred

#to accomplish the same task as earlier 10 times, I made a nested for loop and changed my origional vector indeces to matrix indeces
for (j in 1:length(initPreyVec)) {
  for (i in time) {
    nMatrix[i,j] <- nMatrix[i-1,j] + (r * nMatrix[i-1,j]) - (a * nMatrix[i-1,j] * pMatrix[i-1,j])
    if (nMatrix[i,j] < 0) {
      nMatrix[i,j] <- 0
    }
    pMatrix[i,j] <- pMatrix[i-1,j] + (k * a * nMatrix[i-1,j] * pMatrix[i-1,j]) - (m * pMatrix[i-1,j])
  }
}

# now, the predator or prey abundance for, say, 100 generations, can be compared across 10 different initial prey scenarios:
nMatrix[100,]
pMatrix[100,]

#this is extra, but I'm procrastinating and I though it would also be interesting to compare when each scenario reaches a prey population of 0:
for (i in 1:length(initPreyVec)) {
  cat("Initial population of", initPreyVec[i],"reaches 0 after", which(nMatrix[,i] == 0)[1], "Generations.\n")
}


# now I'm wondering what it looks like graphically, so I put the values into a vector:
popEnd <- (1:length(initPreyVec)) #setting up vector
for (i in 1:length(initPreyVec)) {
  popEnd[i] <- which(nMatrix[,i] == 0)[1]
}
barplot(popEnd, names.arg = initPreyVec ,main ="Prey Generations Until Extinction", xlab = "Initial Population", ylab = "Generations")