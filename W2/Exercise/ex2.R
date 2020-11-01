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

library(psych)

# QUESTION 1
auto_df <- read.csv("Auto.csv")
head(auto_df)
str(auto_df)

# part (a)
auto_df$horsepower <- as.numeric(as.character(auto_df$horsepower))
str(auto_df)
linear_reg <- lm(formula = mpg ~ horsepower, data = auto_df)
linear_reg
summary(linear_reg)

# The horsepower variable is originally of type "character", hence being read as a factor variable. We need to convert to numeric type first before running linear regression.


# part (b)
# Yes, there is a strong relationship between the predictor and the response. Based on the results from the linear regression model, 
# horsepower variable is significant as the p-value is very small, almost zero. 
# Hence, we can reject the null hypothesis of horsepower beta coefficient = 0

# The relationship between the predictor and response is negative. As shown from the linear regression model results, 
# horsepower variable has a negative beta coefficient.


# part (c)
predict98 <- linear_reg$coefficients[1] + linear_reg$coefficients[2] * 98
as.numeric(predict98)

predict.lm(linear_reg, newdata = data.frame(horsepower = 98), interval = c("confidence"), level = 0.99)
# fit      lwr      upr
# 24.46708 23.81669 25.11747

# predicted mpg = 24.46708
# 99% confidence interval = [23.81669, 25.11747]


# part (d)
# use = "pairwise.complete.obs" excludes entries whenever one of the entries is NA
cor(auto_df$mpg, auto_df$horsepower, use = "pairwise.complete.obs")
# correlation = 0.7784268

cor(auto_df$mpg, auto_df$horsepower, use = "pairwise.complete.obs") ^ 2
# r^2 = 0.6059483


# part (e)
ggplot(data = auto_df, aes(x = horsepower, y = mpg)) + geom_point(na.rm = TRUE) + geom_smooth(method = "lm", na.rm = TRUE, se = FALSE)


# part (f)
autoplot(linear_reg)
# Residual vs Fitted Plot
# A good linear fit should have the residuals randomly scattered. 
# In this model we see that the residuals decrease, and then increase as the number of fitted residuals increase.

# Normal QQ plot
# The distribution of the residuals is not normal at the extreme tails. 
# This indicates that the data might have evidence of some non-linearities and outliers.



# QUESTION 2
# part (a)
pairs.panels(x = auto_df, ellipses = F, lm = T, breaks = 10, hist.col = "blue")


# part (b)
cor(x = auto_df[ , c(1:length(auto_df) - 1)])


# part (c)
auto_df1 <- subset(auto_df, select = -c(name))
mul_lin_reg <- lm(formula = mpg ~ ., data = auto_df1)
summary(mul_lin_reg)

# p-value is very small for this multiple linear regression model. 
# Hence, we can reject the null hypothesis that all beta_i are zero
# There is a strong relationship between the predictors and response.

# displacement, weight, year and origin appear to have a statistically significant relationship to the response

# the coefficient year variable has a positive coefficient and its p-value is close to zero. 
# this shows that year is positively related to mpg where for every unit of increase in year, 0.750773 miles per gallon is added, when everything else remains the same.



# QUESTION 3
# part (a)
set.seed(1)
x1 <- runif(100)
x2 <- 0.5 * x1 + rnorm(100)/10
y <- 2 + 2 * x1 + 0.3 * x2 + rnorm(100)


# part (b)
cor(x1, x2)
# correlation between x2 and x2 = 0.8351212

ggplot(cbind(x1, x2), aes(x = x1, y = x2)) + geom_point()


# part (c)
df3 <- data.frame(y = y, x1 = x1, x2 = x2)
model3 <- lm(y ~ ., df3)
summary(model3)

# We reject the null hypothesis B_1  = 0 at 5% level
# we do not reject null hypothesis B_2 = 0 at 5% level


# part (d)
model3a <- lm(y ~ x1)
summary(model3a)
# the estimated B_1 is close to the true value
# we can reject the null hypothesis as the p-value is close to zero


# part (e)
model3b <- lm(y ~ x2)
summary(model3b)
# the estimated B_2 value is quite far from the true value
# we can reject the null hypothesis as the p-value is close to zero


# part (f)
# There exists multi-collinearity in x1 and x2
# This is evident from being able to reject one null hypothesis B_i = 0, but unable to reject the other in the multiple linear regression model
# Whereas in single linear regression, we can reject the null hypothesis.
# This is caused by multi-collinearity.


# QUESTION 4
boston <- read.csv("Boston.csv")

# part (a)
model1 <- lm(medv~crim, data=boston)
model2 <- lm(medv~zn, data=boston)
model3 <- lm(medv~indus, data=boston)
model4 <- lm(medv~chas, data=boston)
model5 <- lm(medv~nox, data=boston)
model6 <- lm(medv~rm, data=boston)
model7 <- lm(medv~age, data=boston)
model8 <- lm(medv~dis, data=boston)
model9 <- lm(medv~rad, data=boston)
model10 <- lm(medv~tax, data=boston)
model11 <- lm(medv~ptratio, data=boston)
model12 <- lm(medv~black, data=boston)
model13 <- lm(medv~lstat, data=boston)

ggplot(boston, aes(x = lstat, y = medv)) + geom_point(na.rm = TRUE) + geom_smooth(method = "lm", na.rm = T, se = F)


# part (b)
bmodel_m <- lm(formula = medv ~ ., data = boston)
summary(bmodel_m)


# part (c)
Ind <- c(model1$coef[2], model2$coef[2], model3$coef[2], model4$coef[2], model5$coef[2],
         model6$coef[2], model7$coef[2], model8$coef[2], model9$coef[2], model10$coef[2],
         model11$coef[2], model12$coef[2], model13$coef[2])
All <- bmodel_m$coef[2:14]
ggplot(cbind(Ind, All), aes(Ind, All)) + geom_point() + geom_smooth(method = "lm", se = F) + 
  ggtitle("Coefficient relationship") + xlab("Simple linear regression") + ylab("Multiple linear regression")

# The figure seems to indicate a fairly positive relationship between the results from the simple and multiple linear regression models. 
# The relationship seems to be linear too.


# part (d)
modelpoly2 <- lm(medv ~ poly(lstat, 2 , raw = TRUE), data = boston)
summary(modelpoly2)
# Yes, adding higher-degree terms helps improve the fit. 
# Beyond degree 5, adding additional terms does not seem to improve the model (additional parameters do not remain significant).



# QUESTION 5
wine <- read.csv("winedata.csv")
str(wine)

# part (a)
wine$age91 <- 1991 - wine$vintage
wine$age92 <- 1992 - wine$vintage

# average price of wine that were 15 years or older at 1991 auction = 96.43563
mean(wine$price91[wine$age91 >= 15])
# alternative code
mean(subset(wine$price91,wine$age91>=15))


# part (b)
# average price of wine in 1991 auction that produced in years when harvest rain was below average and temp diff was below average = 72.86714
mean_hrain <- mean(wine$hrain)
mean_temp_diff <- mean(wine$tempdiff)
mean(wine$price91[wine$hrain < mean_hrain & wine$tempdiff < mean_temp_diff])


# part (c)
wine_train <- subset(wine, wine$vintage <= 1981)
model_logy <- lm(formula = log(price91) ~ age91, data = wine_train)
summary(model_logy)
# R-square value = 0.6675


# part (d)
confint(model_logy, level = 0.99)
#                 0.5 %     99.5 %
# (Intercept) 3.15900093 3.98388288
# age91       0.02287254 0.06234705


# part (e)
wine_test <- subset(wine, wine$vintage > 1981)
pred_wine <- predict(model_logy, newdata = wine_test)
pred_wine

sse <- sum((log(wine_test$price91) - pred_wine) ^2 )
sst <- sum((log(wine_test$price91) - mean(log(wine_train$price91))) ^2 )
r2 <- 1 - sse / sst
r2 

# r2 value = 0.9213742


# part (f)
# In comparison to the results for the Bordeaux wine data, the training (model) R2 and test R2 is higher for this new dataset. 
# This seems to indicate that the variation in the prices of the wine in this dataset is explained much more by the age of the wines 
# in comparison to the Bordeaux dataset.


# part (g)
model_g <- lm(formula = log(price91) ~ age91 + temp + hrain + wrain + tempdiff, data = wine_train)
summary(model_g)
# r2 value = 0.7938


# part (h)
# yes this model is preferred as it has a higher adjusted r2 value


# part (i)
# statement 3 on hrain


# part (j)
model_j <- lm(formula = log(price91) ~ age91 + hrain + temp, data = wine_train)
summary(model_j)



# QUESTION 6
iris.data <- iris[, -5]
iris.sp <- iris[, 5]
pairs.panels(iris.data, ellipses = F, lm = T, breaks = 10, hist.col = "blue")

pr.out <- prcomp(iris.data, scale = F)
summary(pr.out)

pr.var = pr.out$sdev^2
pve = pr.var / sum(pr.var)

# Plot cumulative graph
plot(cumsum(pve), xlab = "Principal Component", ylab = "Cumulative Proportion of Variance Explained",
     ylim = c(0,1), type = 'b') + abline(h = 0.9, col = "red") #abline refers to the threshold

