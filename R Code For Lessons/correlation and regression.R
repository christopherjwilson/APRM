# multivariate normal example using the MASS package


require(MASS)

#make this reproducible
set.seed(2)

#how many draws in our starting data set?
n <- 1000

# how many draws do we want from this distribution?
drawCount <- 1

myData   <- rnorm(n, 5, .6)
adPlays <- myData  + rnorm(n, 8, .25)
adSpend <- myData  + rnorm(n, 1000, .25)
Sales  <- myData  + rnorm(n, 10000, .1)

data <- data.frame(Sales,adPlays,adSpend)
model1 <- lm(Sales~adPlays+adSpend)

summary(model1)

write.table(data, "d:/mydata.txt", sep="\t")

# Other useful functions 
coefficients(fit) # model coefficients
confint(fit, level=0.95) # CIs for model parameters 
fitted(model1) # predicted values
residuals(fit) # residuals
anova(fit) # anova table 
vcov(fit) # covariance matrix for model parameters 
influence(model1)
# regression diagnostics


plot(Relationship, Outcome)
#add regression line
abline(lm(Outcome~Relationship), col="red") # regression line (y~x)


#example of less relationship
plot(Group1, Group2, xlab="Outcome",ylab="Wealth")

mydata=data.frame(Relationship,Outcome)

# write out text datafile and
# an SPSS program to read it
library(foreign)
write.foreign(mydata, "d:/mydata.txt", "d:/mydata.sps",   package="SPSS")


