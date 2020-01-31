# lab step #3: variables for number of guests and number of bags of chips
chips <- 5
guests <- 8

# lab step #5: each guest will eat an average (eatavg) of 0.4 bags of chips
eatavg <- 0.4

# lab step 7: expected amount of leftover bags of chips, calculated from number of guests, average amount eaten, and including self
leftover <- chips - ((guests * eatavg) + eatavg)

# lab step 8: movie ranking vectors, 1 per person, in numerical episode order
self <- c(7,9,8,1,2,3,4,6,5)
penny <- c(5,9,8,3,1,2,4,7,6)
lenny <- c(6,5,4,9,8,7,3,2,1)
stewie <- c(1,9,5,6,8,7,2,3,4)

# lab step 9: accessing penny's and lenny's rankings for ep 4
PennyIV <- penny[4]
LennyIV <- lenny[4]

#lab step 10: rombining all 4 sets of rankings, with column labels from vector object names (deparse.level = 1)
rankings <- cbind(self, penny, lenny, stewie, deparse.level = 1)

str(PennyIV)
str(rankings)
# PennyIV is just one number object, whereas rankings is an object with 9 rows and 4 columns, and column labels

dataframe <- data.frame(self, penny, lenny, stewie)
asdataframe <- as.data.frame(rankings)

# "rankings" and "dataframe" are different types of objects in R even though the data in both is the same. The R object type for the step 10 "rankings" is "double", and the type for the data frame is "list", which means that R stores these data differently.

# lab step 14: vector of character strings, episode numbers
numerals <- c("I","II","III","IV","V","VI","VII","VIII","IX")

# lab step 15: adding row names to data frames/matrices
row.names(rankings) <- numerals
row.names(dataframe) <- numerals
row.names(asdataframe) <- numerals

rankings[3,]
dataframe[,4]

dataframe[5,"self"]
dataframe[2, "penny"]

dataframe[4:6,]
dataframe[c(1, 3, 7),]

dataframe[c(4, 6),c("penny", "stewie")]

# lab step 23: swapping Lenny's rankings for episodes II and V
dataframe[c(2, 5), 3] #check values before
new2 <- dataframe[5, 3] #store of 5 to change 2
dataframe[5, 3] <- dataframe[2,"lenny"] #swap 2 to 5 directly
dataframe[2, 3] <- new2 #put stored 5 into 2
dataframe[c(2, 5), 3] #check values after

rankings["III", "penny"]
dataframe["III", "penny"]

# lab step 25: At this point I realize I've been using a mixture of names and indexes the whole time without noticing, so I went back and changed names to indexes for #23

dataframe[c("II", "V"), "lenny"]
newII <- dataframe["V", "lenny"]
dataframe["V", "lenny"] <- dataframe["II", "lenny"]
dataframe["II", "lenny"] <- newII
dataframe[c("II", "V"), "lenny"]
# to undo 23, I just repeated the same lines

dataframe$lenny
dataframe$lenny[2]

# lab step 26: re-doing the swap from step 23 using $ operator
dataframe$lenny[c(2, 5)]
finalII <- dataframe$lenny[5]
dataframe$lenny[5] <- dataframe$lenny[2]
dataframe$lenny[2] <- finalII
dataframe$lenny[c(2, 5)]
