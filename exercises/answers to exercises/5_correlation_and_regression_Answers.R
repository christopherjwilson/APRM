## Lesson 6: Correlation and regression exercises

## 1. load the "severity_data.csv" file from the datasets folder into R
read.csv("datasets/severity_data.csv")

## We will be examining the relationship between "level_of_severity" and "wellbeing_after_3_months"
## 2. Check the assumptions for correlation
plot(severity_data$wellbeing_after_3_months, severity_data$level_of_severity)
hist(severity_data$wellbeing_after_3_months)
hist(severity_data$level_of_severity)
shapiro.test(severity_data$wellbeing_after_3_months)
shapiro.test(severity_data$level_of_severity)

## 3. Run the correlation analysis and interpret the output. Report your findings below:
cor.test(severity_data$wellbeing_after_3_months, severity_data$level_of_severity)
## R = -0.66
## P <0.01

## 4. Run a regression analysis to see if "level_of_severity" predicts "wellbeing_after_3_months"
model1 <- lm(data=severity_data, formula = wellbeing_after_3_months ~ level_of_severity)
summary(model1)

## 5. Check the assumptions of Regression
plot(model1)

## 6. Report the overall model R squared value and the overall significance:
summary(model1)
## R2 = 0.4372
## P <0.01

## 7. Using the coefficient values, write the regression equation out below:
## 8. Using the regression equation: calculate what wellbeing level we would predict, if someone's severity level were 20 
predicted_wellbeing <- (-0.73102 * 20) + 12.77


