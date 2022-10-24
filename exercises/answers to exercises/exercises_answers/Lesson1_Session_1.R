# Use the file menu to create a new R script
# 2. Save the script and call it Analysis1.R
# 3. You can use the /# symbol before lines of text to create comments in your script. This
#   helps to keep it organised and seprate chunks of code. At the top of your new script
# file, create a comment that says “Introduction to R: Lesson 1”

# 4. Ask to other people in the room what age they are. Create a data vector with 3 values,
# your age and the two others. Name your data object Ages (See “Basic Functions” for
#                                                          example of creating a data vector).

Ages <- c(23,43,39,18)

# 5. Use the mean function to calculate the mean age of your Ages dataset.
mean(Ages)

# 6. Use the sd function to calculate the standard deviation of your Ages dataset.
sd(Ages)
# 7. Create a new data object called Ages2 which is your Ages dataset multiplied by 2.
Ages2 <-Ages*2

# 8. ggplot2 is a package that can make publication-standard plots of your data. We will be
# using it later. Install the package ggplot2 and use the library command to load it.
install.packages(ggplot2)
# 9. Save your script file if you have not already done so (keep it open).
