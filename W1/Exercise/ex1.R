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
ggplot(data = limited, aes(x = Age)) + geom_histogram(binwidth = 5, na.rm = TRUE)
# OR
hist(limited$Age)
# aged around 60 is the best represented age group in the population


# part (l)
# plot(x = limited$Age, y = limited$Info.On.Internet)
max(table(limited$Info.On.Internet, limited$Age))
# 6 interviewees


# part (m)
jitter(c(1, 2, 3))
?jitter # add a small amount of noise to a numeric vector
# ie. adds some random zero noise to the vector
# [1] 1.054624 2.136007 2.972757


# part (n)
plot(jitter(limited$Age), jitter(limited$Info.On.Internet))
# relationship between the two variables:
# older age is mildly associated with smalller values of the Info.On.Internet.
# However this does not seem to be particularly strong.

# use ggplot to plot jitter plot
ggplot(data = limited, aes(x = Age, y = Info.On.Internet)) + geom_point(position = "jitter", na.rm = TRUE)


# part (o)
# tapply(vector, index, function)
tapply(limited$Info.On.Internet, limited$Smartphone, mean, na.rm = TRUE)
#        0        1 
# 2.922807 4.367556 
# average info.on.internet is 2.922807 for non-smartphone users
# average info.on.internet is 4.367556 for smartphone useres


# part (p)
tapply(limited$Tried.Masking.Identity, limited$Smartphone, mean, na.rm = TRUE)
#         0         1 
# 0.1174377 0.1925466
# 0.1925466 proportion of smartphone users tried masking their identity when using the internet
# 0.1174377 proportion of non-smartphone users tried masking their identity when using the internet

# OR
tapply(limited$Tried.Masking.Identity, limited$Smartphone, table)
# table function gives number of counts from dataset  

# $`0`
# 
# 0   1 
# 248  33 
# 
# $`1`
# 
# 0   1 
# 390  93 



# Question 7
swiss
str(swiss)

# part (a)
?stars() # radar plots
# default key.loc = NULL. add a coordinate to the plot to include the variable legend radar plot
stars(x = swiss, key.loc = c(5, 20))
# The county (canton) of Sierre has a high percentage of Catholics, 
# high fertility rate and a large number of men working in agricluture (rural county). 
# Education and examination percentages are low and so is the Infant mortality rate.


# part(b)
# column 2 3 5 6: not fertility / education
# column 1: fertility
# column 4: education
# location = c(x, y) axes
# fertility against education: c(4, 1)
# scatter plot with star plots as data points of other (non x and y) variables
stars(x = swiss[ , c(2, 3, 5, 6)], location = swiss[ , c(4, 1)], len = 3,
      # len = 3 to set the size of the radar plot (default = 1)
      # axes = TRUE to add axis to the plot
      axes = T, main = "Fertility against Education", xlab = "Education", ylab = "Fertility")

stars(x = swiss[ , c(2, 3, 5, 6)], location = swiss[ , c(4, 1)], labels = NULL, len = 3,
      # labels = NULL to remove star plot labels (the data points)
      axes = T, main = "Fertility against Education", xlab = "Education", ylab = "Fertility")


# part(c)
stars(x = swiss[ , c(2, 3, 5, 6)], location = swiss[ , c(4, 1)], draw.segments = TRUE, key.loc = c(1, 12), len = 3, labels = NULL, 
      # draw.segments = TRUE to draw segment diagram (ie. pie chart looking star plot), not star/radar plot
      axes = T, main = "Fertility against Education", xlab = "Education", ylab = "Fertility")


# part (d)
# In counties with a high Catholic population and a large number of men working in agriculture, 
# education levels are low and fertility is very high. 
# There is no clear pattern for infant mortality as such. 
# Areas where there are more Protestants than Catholics, there seems to be higher levels of education.



# Question 8
# part (a)
Parole <- read.csv("Exercise/Parole.csv")
table(Parole$Violator, Parole$Male)
#     0   1
# 0 116 481
# 1  14  64

14/(14+64)
# 0.1794872 of parole violators are female


# part (b)
table(Parole$State, Parole$Crime)
#           Driving Drugs Larceny Other
# Kentucky        4    64      10    42
# Louisiana       5    20      15    42
# Other          34    34       9    66
# Virginia       58    35      72   165

# drugs is the most common crime in Kentucky


# part (c)
ggplot(data = Parole, aes(x = Age)) + geom_histogram()


# part (d)
ggplot(data = Parole, aes(x = Age)) + geom_histogram(binwidth = 5, center = 17.5, closed = c("left"))
# center = 17.5 to set the center of one of the bins
# closed = c("left) to indicate that left endpoint is included in the bin, but the right endpoint is not
# default bins: left closed, right opened [x, y)

# [20,25) age bracket has the most parolees


# part (e)
ggplot(data = Parole, aes(x = Age)) + geom_histogram(binwidth = 5, center = 17.5, closed = c("left"), color = c("blue"))
# color = c("blue") changes outline color of the bars


# part (f)
ggplot(data = Parole, aes(x = Age)) + geom_histogram(binwidth = 5, center = 17.5, closed = c("left"), color = c("blue")) + facet_grid(Male ~ .)
# facet_grid to create separate plots based on a specified category
# horizontal bars, plots are on top of each other

# [35,40) age bracket has the most female parolees

# split in vertical direction (plots are stacked): col ~ . 
# split in horizontal direction (plots are side by side): . ~ col (ie. one panel per col)
# there can be more than one col specified. Eg = . ~ col1 + col2
# source: https://stackoverflow.com/questions/14976331/use-of-tilde-in-r-programming-language

# eg. facet_grid(dose ~ supp) means rows are dose, columns are sup
# . means all other columns in the data frame that are not in the formula


# part (g)
ggplot(data = Parole, aes(x = Age)) + geom_histogram(binwidth = 5, center = 17.5, closed = c("left"), color = c("blue")) + facet_grid(. ~ Male)

# changing from facet_grid(Male~.) to facet_grid(.~Male):
# puts the histograms side-by-side instead of on top of each other
# vertical bars, plots are side by side


# part (h)
# combined histogram but color the groups differently using fill = as.factor(column)
# stacked bars
ggplot(data = Parole, aes(x = Age, fill = as.factor(Male))) + geom_histogram(binwidth = 5, closed = "left", center = 17.5, color = "blue")


# part (i)
# non stacked bars. overlapped bars.
# use alpha = 0.5 value to make the bars semi-transparent, so that we can see both colours
ggplot(data = Parole, aes(x = Age, fill = as.factor(Male))) + geom_histogram(binwidth = 5, closed = "left", center = 17.5, color = "blue", position = "identity", alpha = 0.5)

# [15,20) , [55, 60) and [65, 70) age brackets do not have female paroles.


# part (j)
# overlaying better visualises the data than faceting. 
# it is easier to compare between the factors.


# part (k)
ggplot(data = Parole, aes(x = TimeServed)) + geom_histogram(binwidth = 1, center = 0.5, closed = "right")
# most common length of time served is (5, 6] months (ie. 5 to 6 months)


# part (l)
ggplot(data = Parole, aes(x = TimeServed)) + geom_histogram(binwidth = 1, center = 0.5, closed = "right") + facet_grid(Crime ~ .)
# crime type driving has no observations where time served is less than one month


# part (m)
ggplot(data = Parole, aes(x = TimeServed, fill = Crime)) + geom_histogram(binwidth = 1, center = 0.5, closed = "right", position = "identity", alpha = 0.5)
# With four different groups, it can be hard to tell them apart when they are overlayed, especially if they have similar values.
# ggplot doesn't let us overlay plots with more than two groups.
# Overlaying the plots doesn't allow us to observe which crime type is the most common.
       