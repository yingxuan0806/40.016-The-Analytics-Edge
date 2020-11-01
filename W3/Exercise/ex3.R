rm(list=ls())

baseballlarge <- read.csv("baseballlarge.csv")

# number of entries can be counted with length()
length(table(baseballlarge$Year)) 
names(table(baseballlarge$Year))
