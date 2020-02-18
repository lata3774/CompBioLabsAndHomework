# Lab04: For loops
# Part 1
# 1: for loop to print hi 10x
for( i in seq(1, 10) ) {
  print("hi")
}

# 2: allowance/gum problem, printing total amount of money at the end of each week for 8 weeks
allowance <- 5
gumCost <- 1.34
startMoney <- 10
gumPerWeek <- 2
weeks <- seq(1,8)

for( i in weeks ) {
  print(startMoney + (i * (allowance - (gumCost * gumPerWeek))))
}

# 3: shrinking population
popSize <- c(1:8)
popStart <- 2000
growthRate <- -.05
years <- seq(2,8)

popSize[1] <- popStart
for(i in years){
  popSize[i] <- popSize[i-1] + (popSize[i - 1] * growthRate)
}
popSize

# 4: Population abundance over time
# equation: n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )
# n[t] is abundace of population at time t
# r is intrinsic growth rate
# K is environmental carrying capacity

nStart <- 2500
K <- 10000
r <- 0.8
time <- seq(1,12)
abundance <- c(1:12)

abundance[1] <- nStart
for (i in 2:length(time)) {
  abundance[i] <- abundance[i-1] + ( r * abundance[i-1] * (K - abundance[i-1])/K )
}
abundance

# Practice writing "for loops" AND practice storing the data produced by your loops in arrays
# 5a: 
zeroVec <- rep(0, 18)

# 5b:
for ( i in seq(1,18) ) {
  zeroVec[i] <- 3 * i
}

# 5c: 
oneZeroVec <- rep(0,18)
oneZeroVec[1] <- 1
for ( i in seq(2,18) ) {
  oneZeroVec[i] <- 1 + (2 * oneZeroVec[i-1])
}

# 6: fibonacci sequence, starting with 0
fibonacci <- rep(0,20)
fibonacci[c(1,2)] <- c(0,1)
for (i in 3:length(fibonacci)) {
  fibonacci[i] <- fibonacci[i-2] + fibonacci[i-1]
}

# 7:
# data already stored from question 4
plot(time,abundance)