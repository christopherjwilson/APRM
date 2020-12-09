#generate dataset
library(MASS)
# data1
mu <- rep(0,2)
Sigma <- matrix(.7, nrow=2, ncol=2) + diag(2)*.3

rawvars <- mvrnorm(n=100, mu=mu, Sigma=Sigma)
cov(rawvars); cor(rawvars)

pvars <- pnorm(rawvars)
cov(pvars); cor(pvars)

data1 <- as.data.frame(pvars)


mu <- rep(0,2)
Sigma <- matrix(.7, nrow=2, ncol=2) + diag(2)*.4

rawvars <- mvrnorm(n=100, mu=mu, Sigma=Sigma)
cov(rawvars); cor(rawvars)

pvars <- pnorm(rawvars)
cov(pvars); cor(pvars)

data2 <- as.data.frame(pvars)
data2$V2 <- data2$V2 + 10
dataFull <- rbind(data1,data2)

data3 <- 0.5+1*data2$V1+  0.2+1*data2$V2+ .8*data2$V1*data2$V2 + rnorm(100, 10)
dataFull$V3 <- data3

moderationData <- dataFull


library(dplyr)

moderationData <- moderationData %>% rename(
  aggression = V3,
   timePlaying = V2,
    impulsivity = V1
)



model <- lm(data = moderationData, aggression ~ timePlaying)

modelMod <- lm(data = moderationData, aggression ~ timePlaying*impulsivity)

summary(model)
summary(modelMod)

library(interactions)
interact_plot(model = modelMod, pred = timePlaying, modx = impulsivity )
library(rockchalk)
slopes <- plotSlopes(modelMod, plotx = "timePlaying", modx = "impulsivity")
testSlopes <- testSlopes(slopes)
plot(testSlopes)

write.csv(moderationData, "moderationData.csv")
