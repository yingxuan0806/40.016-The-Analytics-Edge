rm(list=ls())
setwd("~/Documents/SUTD/Term 6/TAE/W1")

if(!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2)
}

# Question 1
x <- c(4, 2, 6)
y <- c(1, 0 , -1)

length(x) # 3
sum(x) # 12
sum(x^2) # element-wise square value = 4^2 2^2 6^2 = 56
x + y # element-wise addition = 5 2 5
x * y # element-wise multiplication = 4 0 -6
x - 2 # element-wise subtraction = 2 0 4
x^2 # element-wise exponential = 16 4 36
x * y[1:2] #returns error as the first two elements of y is not a multiple of x vector



# Question 2
7:11 # start and end values are inclusive in R = 7 8 9 10 11
seq(2, 9) # 2 3 4 5 6 7 8 9
seq(4, 10, by = 2) # 4 6 8 10

seq(3, 30, length = 10) # total of 10 elements to be returned
# interval = (30 - 3) / (10 - 1) = 27 / 9 = 3
# returns 3  6  9 12 15 18 21 24 27 30

seq(6, -4, by = -2) # 6 4 2 0 -2 -4



# Question 3
?rep
rep(2, 4) # rep(2, times = 4) = 2 2 2 2
# OR rep(2, each = 4)
# OR rep(2, length.out = 4)

rep(c(1, 5), 4) # 1 5 four times
# 1 5 1 5 1 5 1 5 1 5 

rep(c(1, 2), c(4, 4)) # four times each
# each element repeated together in a chunk before moving to next element
# 1 1 1 1 2 2 2 2



# Question 4
x <- c(5, 9, 2, 3, 4, 6, 7, 0, 8, 12, 2, 9)
x[2] # 9
x[2:4] # 9 2 3
x[c(2, 3, 6)] # 9 2 6
x[c(1:5, 10:12)] # 5 9 2 3 4 12 2 9
x[-(10:12)] # all elements except the 10th to 12 element
# 5 9 2 3 4 6 7 0 8



# Question 5
x <- matrix(data = c(3, 2, -1, -1), nrow = 2, ncol = 2, byrow = TRUE)
# OR rbind(c(3, 2), c(-1, -1)))
x

y <- cbind(c(1, 0), c(4, 1), c(0, -1))
y

2 * x
# element-wise multiplication
#     [,1] [,2]
# [1,]    6    4
# [2,]   -2   -2

x * x
# element-wise multiplication
#     [,1] [,2]
# [1,]    9    4
# [2,]    1    1

x %*% x
# matrix multiplication
#     [,1] [,2]
# [1,]    7    4
# [2,]   -2   -1

x %*% y
# matrix multiplication
#       [,1] [,2] [,3]
# [1,]    3   14   -2
# [2,]   -1   -5    1

t(y)
# transpose matrix
#       [,1] [,2]
# [1,]    1    0
# [2,]    4    1
# [3,]    0   -1


solve(x)
# get inverse matrix of x

x[1, ] # 3 2
x[2, ] # -1 -1
x[ ,2] # 2 -1
y[1,2] # 4
y[ ,2:3] # returns a matrix: second and third column of all rows
#       [,1] [,2]
# [1,]    4    0
# [2,]    1   -1



# Question 6
# part (a)
poll <- read.csv("Exercise/AnonymityPoll.csv")
summary(poll)
str(poll)
view(poll)

nrow(poll)
# 1002 people participated in the poll.


# part (b)
table(poll$Smartphone)
# 487 people use a smartphone
# 472 people do not use a smartphone
summary(poll$Smartphone)
# 43 people did not respond to the question, resulting in a missing value.


# part (c)
table(poll$Smartphone, poll$Internet.Use) # table(row, col)
# 186 not used both smartphone and internet
# 285 not used smartphone, but used internet
# 17 used smartphone, but not internet
# 470 used both smartphone and internet


# part (d)
summary(poll$Internet.Use)
# OR
sum(is.na(poll$Internet.Use))
# 1 missing value for internet use

summary(poll$Smartphone)
# OR
sum(is.na(poll$Smartphone))
# 43 missing value for internet use


# part (e)
limited <- subset(poll, poll$Internet.Use == 1 | poll$Smartphone == 1)
nrow(limited)
# 792 interviewees are in the new data frame


# part (f)
summary(limited)
# 8 variables have missing values in the limited data frame
# Smartphone: 20
# Age: 22
# Conservativeness: 45
# Worry.About.Info: 2
# Privacy.Importance: 5
# Anonymity.Possible: 39
# Tried.Masking.Identity: 8
# Privacy.Laws.Effective: 65


# part (g)
mean(limited$Info.On.Internet)
# 3.795455


# part (h)
sum(limited$Info.On.Internet == 0)
# 105 interviewees

sum(limited$Info.On.Internet == 11)
# 8 interviewees


# part(i)
mean(limited$Worry.About.Info, na.rm = TRUE)
# 0.4886076 proportion of interviewees worry about how much information is available them on the internet


# part(j)
mean(limited$Anonymity.Possible, na.rm = TRUE)
# 0.3691899 proportion of interviewees think it is possible to be completely anonymous on the internet


# part (k)
ggplot(data = limited, aes(x = Age)) + geom_histogram(binwidth = 20, na.rm = TRUE)
# OR
hist(limited$Age)
# aged around 60 is the best represented age group in the population


# part (l)
plot(x = limited$Age, y = limited$Info.On.Internet)
