### Basic tests Exercises - just examples: we did not cover these in detail in the class

# Using the treatmentData: 

treatmentData<- read.csv("Datasets/treatmentData.csv")

# 1. Perform a t-test to see if there is a difference between the two treatment groups in post treatment

t.test(treatmentData$post_treatment ~ treatmentData$treatment_group)

# 2. Import the data file "treatmentData_LONG.csv" - we will use this for all of the below exercises

treatmentData_LONG<- read.csv("Datasets/treatmentDataLONG.csv")

# 3. View the data by clicking on it - what is the difference between this file and the other treatment dataset?

# ANSWER: It's in the long format (1 row per response), instead of the wide format (1 row per participant)

# 4. Here is an example of how to run a between groups ANOVA in R
# We will cover this in a later session
# Notice how we use the summary() command to get a summary of the ANOVA results

aov_1 <- aov(wellbeing ~ treatment_group*timepoint + Error(client/timepoint), data=treatmentData_LONG)
Summary(aov_1)




