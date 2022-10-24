## 0. Install the ggplot2 package and then load it using the library() command
library(ggplot2)

## 1. Create a plot using the salesData dataset - put the salary variable on the X axis and the valueOfSales variable on the Y axis.

ggplot(salesData, aes(x= salary, y=valueOfSales)) 

## 2. Add the geom "point" and assign colour to the married variable and size to the numberOfVisits variable

ggplot(salesData, aes(x= salary, y=valueOfSales)) + geom_point()


## 3. Rename the plot title, axes labels and legend labels to something appropriate

ggplot(salesData, aes(x= salary, y=valueOfSales)) + 
  geom_point() +
  labs(x="Salary", y="Value of Sales", title = "Scattterplot of Sales")


## 4. Store this plot as an object named “plot1”

plot1 <- ggplot(salesData, aes(x= salary, y=valueOfSales)) + 
  geom_point() +
  labs(x="Salary", y="Value of Sales", title = "Scattterplot of Sales")


## 5. Create a different plot using the salesData dataset - the married variable on the X axis and use the stat_summary() function to show the mean valueOfSales on the Y axis, with the geom bar

ggplot(salesData, aes(x=married,y=valueOfSales)) + stat_summary(fun.y = "mean", geom = "bar")


## 6. Inside the ggplot aes() function, add the option fill=“married” to the code to change the fill colour of the bars based on the married variable

ggplot(salesData, aes(x=married,y=valueOfSales, fill = married)) + stat_summary(fun.y = "mean", geom = "bar")


## 7. Store this plot as a plot named “plot2” 

plot2 <- ggplot(salesData, aes(x=married,y=valueOfSales, fill = married)) + stat_summary(fun.y = "mean", geom = "bar")


## 8 Save “plot1” as a pdf file

ggsave(plot= plot1, file="plot1.pdf", width = 4, height = 4)

## 8. Save “plot2” as a png file

ggsave(plot= plot2, file="plot2.png", width = 4, height = 4)
