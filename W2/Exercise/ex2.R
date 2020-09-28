rm(list=ls())
setwd("~/Documents/SUTD/Term 6/TAE/W2/Exercise")

if (!require(ggplot2)) {
  install.packages("ggplot2")
  library(ggplot2)
}

if (!require(ggfortify)) {
  install.packages("ggfortify")
  library(ggfortify)
}


# QUESTION 1
auto_df <- read.csv("Auto.csv")
head(auto_df)

# part (a)
linear_reg <- lm(formula = mpg ~ horsepower, data = auto_df)
linear_reg
summary(linear_reg)

