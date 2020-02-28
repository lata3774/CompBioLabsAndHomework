#Lab07
#Lauren Taylor
#February 28, 2020

# Problem 1. Area of a triangle given base and height
triangleArea <- function(base, height) {
  #area of triangle = 0.5 * base * height
  TriArea <- (0.5 * base * height)
  return(TriArea)
}

#test function
triangleArea(10, 9)

# Problem 2: write a function to return absolute value of each number in a vector
myAbs <- function(input) {
  #function only needs to change numbers less than zero by taking negative value of input
  value <- ifelse ( input < 0, -input, input)
  return (value)
}

#test function
myAbs(5)
myAbs(-2.3)
myAbs(c(1.1, 2, 0, -4.3, 9, -12))

# Problem 3: create a fibonacci sequence function that uses two arguments: n integers and starting number
fibonacci <- function( n, first ){
  #return helpful error messages when n or the first number aren't appropriate values
  if (n <= 0) {
    return ("ERROR: n must be greater than 0")
  } else if (n != round(n)) {
    return ("ERROR: n must be an integer")
  } else if (first != 0 && first != 1) {
    return ("ERROR: sequence must start with 0 or 1")
  } else {
    # start 
    # sequence will always be n digits long and have 1 in the second space, so we start with a vector of 1s
    sequence <- rep(1,n)
    # assign first number
    sequence[1] <- first
    #this is enough for n = 1 or n = 2
    if (n > 3) {
      # when n is greater than three, use for loop fibonacci sequence from lab 4 to fill in the rest of the sequence
      for (i in 3:n) {
        sequence[i] <- sequence[i-2] + sequence[i-1]
      }
    }
    return(sequence)
  }
}
#test
fibonacci (10, 0)
# test if n = 1 or n = 2
fibonacci (1, 0)
fibonacci (2, 1)
#test incorrect inputs
fibonacci (10, 2)
fibonacci (-10, 0)
fibonacci (0, 1)
fibonacci (10.5, 0)

# Problem 4
# 4a: function that calculates the square of the difference of two numbers
squareDiff <- function( x, y ) {
  value <- (x - y) ^ 2
  return (value)
}

#test
squareDiff(3,5)
squareDiff(c(2, 4, 6), 4 )

# 4b: function that calculate average of a vector of numbers
myMean <- function (x) {
  #average is the sum of inputs divided by number of inputs
  value <- sum(x) / length(x)
  return (value)
}

#test
myMean(c(5, 15, 10))
# use data provided
myData <- read.csv("DataForLab07.csv")
# make single variable data frame into a vector
myData <- myData$x
myMean(myData)

# 4c: sum of squares function
#calculate the mean
#subtract mean from data point
#square difference
#sum squared differences
sumSquares <- function(x){
  # sum the returns from the square difference function using the mean of the vector (fuction from above) and the values from the vector
  value <- sum(squareDiff(x,myMean(x)))
  return (value)
}

#test
sumSquares(myData)