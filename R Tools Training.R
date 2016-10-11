# Decimal / Real Values data types
x <- 10.5
x
class(x)
is.integer(x)


# Coerce other data types to integer 
as.integer(x)
as.integer(3.14728) # Coerce a numeric value
as.integer("3.14") # Coerce a decimal string
as.integer("Sam") # Coerce a non-decimal string will result in error

as.integer(TRUE)   
as.integer(FALSE) 
 

# Character / String data types
as.character(x)
as.character(3.14728)
x <- "Hello"
y <- "World"

x + y # Error in x + y : non-numeric argument to binary operator

paste(x, y)

sprintf("%s has %d dollars.", "Sam", 100)


# Complex data types 
z <- 1 +2i
z
sqrt(-1)
sqrt(as.complex(-1))


# Logical data types
x <- 1
y <- 2
z <- x > y
z

u <- TRUE
v <- FALSE
u & v # and operator
u | v # or operator
!u


# Vector data structures
x <- c(2, 3 , 5)
y <- c(FALSE, TRUE, FALSE)
z <- c("aa", "bb", "cc")
length(y)
sum(y)

u <- c(x, y, z) # Combine vectors

a <- c(1, 2, 3, 4)
b <- c(2, 3, 4, 5)

# Arithmetic operations only for numeric and logical vectors
5 * a
a + b
b / a

y <- c(FALSE, TRUE, FALSE)
y / y
y + y

# Vector Indexing
a <- c(1, 2, 3, 4)
b <- c(2, 3, 4, 5)
a[3]
a[-3]

s <- c("aa", "bb", "cc", "dd", "ee")
s[c(2,3)]
s[2:4]

L <- c(FALSE, TRUE, FALSE, TRUE, FALSE)
s[L]
s[c(FALSE, TRUE, FALSE, TRUE, FALSE)]


# Matrix 
a <- matrix(c(2, 4, 3, 1, 5, 7),
            nrow = 2,
            ncol = 3,
            byrow = TRUE)

a[2, 3]
a[2, ]
a[ ,2]

b <- matrix(c(2, 3, 4, 5, 6, 7), nrow = 3, ncol = 2)
c <- matrix(c(1, 2, 3), nrow = 3, ncol = 1)

cbind(b, c)

d <- matrix(c(6,2), nrow = 1, ncol = 2)
rbind(b, d)


# Lists
n <- c(2,3,5)
b <- c(FALSE, TRUE)
s <- c("aa", "bb", "cc")
x <- list(bob = n, john = b, zack = s, 5)

x[[1]]

x["bob"]
x$bob
x[["bob"]] 


# Data Frame
n <- c(2,3,5)
b <- c(FALSE, TRUE, FALSE)
s <- c("aa", "bb", "cc")
df <- data.frame(n, s, b)
df

mtcars
mtcars[1, 2] 
mtcars["Mazda RX4", "cyl"] 
head(mtcars) 
nrow(mtcars)
ncol(mtcars)


# Retrieve columns
# Returns column vectors data type
mtcars[[9]] 
mtcars[["am"]] 
mtcars$am 
mtcars[,"am"]

# Returns column slice in data frame data type
mtcars[1]
mtcars["mpg"]
mtcars[c("mpg", "hp")]

# Retrieve rows
mtcars[24,]
mtcars["Camaro Z28", ]


# Logical Indexing
L <- mtcars$am == 0
L
mtcars[L, ]
mtcars[L, ]$mpg


# Create new functions
average <- function(x)
{
  y <- mean(x)
  return(y)
}

data <- c(1:10)
average(data)



# Creating New Variables

# create a table of student scores
student <- data.frame(replicate(6,sample(20:100,1000,rep=TRUE)))

# rename the column names for easy reading
colnames(student) <- c("age","weight", "q1","q2","q3","q4")

# create new variable from an average of the other columns
student$MeanValue <- apply(student[,c("q1","q2","q3","q4")], 2, mean)


# Subsetting Datasets
studentSubset <- subset(student, student$age == 20, select=age:q4)


# Recoding Variables
student$weight[student$weight <= 55] <- "Underweight"
student$weight[student$weight > 55 & student$weight <= 65] <- "Healthy"
student$weight[student$weight > 65] <- "Overweight"


student$tempweight <- student$weight
student$tempweight[student$weight == 99]<-"NA"
student$tempweight[student$weight <= 55]<-"Underweight"
student$tempweight[student$weight > 55 & student$weight <= 65]<-"Healthy"
student$tempweight[student$weight > 65]<-"Overweight"
student 


# Missing Values
# identify missing values
is.na(student)

# exclude missing values in calculation
mean(student$weight, na.rm = TRUE)

# remove observations with missing values
noMissingWeights <- na.omit(student)


# Sorting
studentSorted <- student[order(student$age), ]




# ----------------------------- Visualizing Data ----------------------------------

# Bar Charts

# create a table count of frequency for each category
counts_cylinders <- table(mtcars$cyl)
counts_cylinders

# visualise using a bar plot
barplot(counts_cylinders,
        main="Count of records by Cylinders",
        xlab="Cylnder Count",
        ylab="Frequency")


# Histogram
hist(mtcars$mpg)

hist(mtcars$mpg,
     breaks=10,
     xlab="Miles per Gallon",
     main="Histogram with 10 bins")


# Boxplot

# boxplot of mpg
boxplot(mtcars$mpg, main="Boxplot of Miles/Gallon")

# boxplot of mpg by cylinders
boxplot(mtcars$mpg ~ factor(mtcars$cyl), main="Boxplot of Miles/Gallon for Different Cylinders")


# Scatter Plot
# scatterplot of mpg vs weight
plot(mtcars$wt,
     mtcars$mpg,
     main="Simple Scatter Plot of MPG vs Weight",
     xlab="Car Weight (lbs/100)",
     ylab="Miles Per Gallon")

abline(lm(mpg ~ wt, data=mtcars))



# ----------------------------- Visualizing Data using ggplot2 --------------------
library(ggplot2)
# ggplot example
ggplot(mtcars, aes(x = mpg)) 	+
  geom_histogram(colour = "darkgreen", fill = "blue", binwidth = 5) 


# ggplot example
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(colour = "darkgreen", fill = "blue", binwidth = 5) +
  facet_wrap(~ carb, scales = "free") 


ggplot(mtcars, aes(x=disp, y=mpg, color=factor(am))) + geom_point()


# AES example with acceleration as the aesthetic colour for the points
p <- ggplot(data = mtcars, aes(x = wt, mpg)) + geom_point(aes(color = qsec))
p


# AES example with no. of cylinders as the aestheic colour for the points
p <- ggplot(data = mtcars, aes(x = wt, mpg)) + geom_point(aes(color = factor(cyl)))
p


# geom_xx() example
pd0 <- ggplot(data = mtcars, aes(mpg, wt))
# geom_smooth(method = "lm"). The gray region is one standard error
pd1 <- pd0 + geom_point() + geom_smooth(method = "lm")
pd1


# Statistical Transformations Example
ggplot(mtcars, aes(x=mpg)) + geom_bar(stat='bin')
ggplot(mtcars, aes(x=mpg)) + geom_bar(stat='bin', binwidth=4)


# Position Adjustments
ggplot(mtcars, aes(x=factor(cyl), fill=factor(am))) + geom_bar(position='stack')
ggplot(mtcars, aes(x=factor(cyl), fill=factor(am))) + geom_bar(position='fill')
ggplot(mtcars, aes(x=factor(cyl), fill=factor(am))) + geom_bar(position='dodge')

