### Descriptive Statstics Exercises


## 1. Import the dataset "treatmentData.csv" from the datasets folder

treatmentData <- read.csv("Datasets/treatmentData.csv")

# Use either the read_csv() command or the Import Dataset menu (check the folder name for capital letters etc.)

## 2. Change the variable "treatment_group" to a factor
# remember to overwrite the original variable name when you do so (use "<-")

treatmentData$treatment_group <- as.factor(treatmentData$treatment_group)

# For "baseline" and "post_wellbeing":

  ## 3. What is the mean?
mean(treatmentData$baseline)
mean(treatmentData$post_treatment)
  
  ## 4. What is the 95% trimmed mean?
mean(treatmentData$baseline, trim = .05)
mean(treatmentData$post_treatment, trim=.05)

  ## 5. What is the median?
median(treatmentData$baseline)
median(treatmentData$post_treatment)  
  
  ## 6. What is the range?
max(treatmentData$baseline) - min(treatmentData$baseline)
mean(treatmentData$post_treatment - treatmentData$post_treatment)
  
  ## 7. What is the interquartile range?
quantile(treatmentData$baseline, probs = c(.25,.75)) 
quantile(treatmentData$post_treatment, probs = c(.25,.75))

  ## 8. What is the standard deviation?
sd(treatmentData$baseline)
sd(treatmentData$post_treatment)

  ## 9. Assess the distribution of each using whatever methods you know

hist(treatmentData$baseline)
hist(treatmentData$post_treatment)

shapiro.test(treatmentData$baseline)
shapiro.test(treatmentData$post_treatment)

  # Are the data normally distributed?
Yes

# 10. Use the summary() command to get a summary

summary(treatmentData$baseline)
summary(treatmentData$post_treatment)

# 11. Install and load the "psych" package
library(psych)


# USE THE _LONG DATASET FOR THE BELOW QUESTIONS

# 12.  use the describeBy() function to get a summary of "baseline_wellbeing" and "post_wellbeing"  for each "treatment_group"
# This will give you the wellbeing for each group

describeBy(treatmentData$wellbeing, group= treatmentData$treatment_group)

# to get the wellbeing for each group in each timepoint, you can do this:

describeBy(treatmentData$wellbeing, group= list(treatmentData$treatment_group,treatmentData$timepoint))

# the above is like to a "crosstabs" where you look at combinations of groups from more than one grouping variable


# 13. Repeat question 12 but this time, save the summary as "summary_by_treatment"

summary_by_treatment  <- describeBy(treatmentData, group= treatmentData$treatment_group)

##
## Remember to save this script and keep it open. We will use it for the next exercise ##
##