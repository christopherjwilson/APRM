#install.packages("psych")
library(psych)
#install.packages("tidyverse")
library(tidyverse)

hist(SeverityData$level_of_severity)
hist(SeverityData$wellbeing_after_3_months)

shapiro.test(SeverityData$level_of_severity)
shapiro.test(SeverityData$wellbeing_after_3_months)

plot(SeverityData$wellbeing_after_3_months, SeverityData$level_of_severity)

SeverityData %>% ggplot(aes(x=wellbeing_after_3_months, y=level_of_severity)) +geom_point()

cor.test(SeverityData$level_of_severity, SeverityData$wellbeing_after_3_months)

Model1 <- lm(formula = level_of_severity ~ wellbeing_after_3_months, data= SeverityData)
summary(Model1)

plot(Model1, which = 2)
hist(Model1$residuals)

plot(Model1, which = 1)
plot(Model1, which = 4)
plot(Model1, which = 5)

modelSummary <- summary(Model1)
modelSummary

modelSummary$coefficients
