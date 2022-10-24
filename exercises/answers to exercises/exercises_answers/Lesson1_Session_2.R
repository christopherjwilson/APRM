# load packages
library("tidyverse")
library("haven")

# Import file
salesData <- read_sav("datasets/salesData.sav")

# change the married variable to a factor
salesData$married <- as.factor(salesData$married)

# Arrange from lowest to highest 
salesData %>% arrange(valueOfSales)

#mean Salary

salesData$salary %>% mean()

# Filter the data to include only people who are married

marriedPeople <- salesData %>% filter(married ==1)

# Create a summary of the data to compare the mean and 
# standard deviation of sales for married and non-married customers (1 = married, 2 = not married)

summaryTable <- salesData %>% group_by(married) %>% summarise(mean = mean(valueOfSales), sd = sd(valueOfSales))

# Create a new variable called VIP 
# and label customers who spent over £500 as “VIP” and other customers as “Non-VIP”

salesData %>% mutate(vip = ifelse(valueOfSales > 500, "VIP", "Non-VIP"))
