Graphing and data visualisation
========================================================
author: Christopher Wilson
css: custom.css
width: 1280
height: 720

Advanced Psychological Research Methods

<link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">




By the end of this section, you will be able to:
======================================================== 

- Describe the ggplot "grammar of visualisation": coordinates and geoms
- Write a graph function to display multiple variables on a plot
- Amend the titles and legends of a plot
- Save plots in PDF or image formats




The "grammar of visualisation"
========================================================
 
- Graphs are made up of 3 components:
    * A dataset
    * A coordinate system
    * Visual marks to represent data __(geoms)__

The "grammar of visualisation" #2
======================================================== 
 <img src="img/ggplot1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="100%" style="display: block; margin: auto;" />

- In the above example, the dataset is the _studentData_ that we used previously.
- The _grades_ variable is mapped to the X axis
- The _hoursOfStudy_ variable is mapped to the Y axis

How to code a graph
========================================================

- The graph is created using the following code:
<img src="img/ggplot2.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" width="100%" style="display: block; margin: auto;" />

- In this code, we specify the dataset, the variables for the X and Y axes and the __geom__ that will represent the data points visually (in this case, each datum is a point)

The graph output
========================================================


```r
library(ggplot2)

ggplot(data=studentData, aes(x=grades,y=hoursOfStudy)) + geom_point()
```

<img src="4_Graphs_and_Data_Visualisation-figure/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" height="70%" style="display: block; margin: auto;" />


Changing the geoms leads to different visualisations
========================================================

- If we change from points to lines, for example we get a different plot:


```r
library(ggplot2)

ggplot(data=studentData, aes(x=grades,y=hoursOfStudy)) + geom_line()
```

<img src="4_Graphs_and_Data_Visualisation-figure/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" height="70%" style="display: block; margin: auto;" />


It is possible to represent more variables on the plot
========================================================

- By specifying that colours of our points should be attached to the __route__ variable, the data is now colour-coded


```r
library(ggplot2)

ggplot(data=studentData, aes(x=grades,y=hoursOfStudy)) + geom_point(aes(color = route))
```

<img src="4_Graphs_and_Data_Visualisation-figure/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" height="70%" style="display: block; margin: auto;" />

It is possible to represent more variables on the plot #2
========================================================
- By specifying that size of our points should be attached to the __satisfactionLevel__ variable, the size of the points adjusts


```r
library(ggplot2)

ggplot(data=studentData, aes(x=grades,y=hoursOfStudy)) + geom_point(aes(color = route, size=satisfactionLevel))
```

<img src="4_Graphs_and_Data_Visualisation-figure/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />

It is possible to represent more variables on the plot #3
========================================================

- By specifying that shape of our points should be attached to the __hasDependents__ variable, the shape of the points changes accordingly


```r
library(ggplot2)

ggplot(data=studentData, aes(x=grades,y=hoursOfStudy)) + geom_point(aes(color = route, size=satisfactionLevel, shape=hasDepdendants))
```

<img src="4_Graphs_and_Data_Visualisation-figure/unnamed-chunk-7-1.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />


Changing the axis labels and title on a plot
========================================================
We can change the axis labels and title using the __labs()__ command:

labs(x="Student Grade", y="Hours of Study", title = "Scattterplot of student data")


```r
library(ggplot2)

ggplot(data=studentData, aes(x=grades,y=hoursOfStudy)) + geom_point(aes(color = route, size=satisfactionLevel, shape=hasDepdendants)) + labs(x="Student Grade", y="Hours of Study", title = "Scattterplot of studentdata")
```

<img src="4_Graphs_and_Data_Visualisation-figure/unnamed-chunk-8-1.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" style="display: block; margin: auto;" />

Changing the legend on a plot
========================================================

To change the legend, we use the __labs()__ command too, and reference the relevant property (e.g. size, shape, colour)


```r
library(ggplot2)

  ggplot(data=studentData, aes(x=grades,y=hoursOfStudy)) + 
    geom_point(aes(color = route, size=satisfactionLevel, shape=hasDepdendants)) +
  labs(x="Student Grade", y="Hours of Study", title = "Scattterplot of studentdata", color="Route of study", size="Satisfaction level", shape="Has dependents?")
```

<img src="4_Graphs_and_Data_Visualisation-figure/unnamed-chunk-9-1.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" style="display: block; margin: auto;" />

Storing plots to be recalled later
========================================================
- Plots can be assigned to objects in R and recalled later, just like any other piece of data


```r
library(ggplot2)

## Create plot and store it as "myPlot" object

myPlot <- ggplot(data=studentData, aes(x=grades,y=hoursOfStudy)) +
  geom_point(aes(color = route, size=satisfactionLevel, shape=hasDepdendants)) +
  labs(x="Student Grade", y="Hours of Study", title = "Scattterplot of studentdata", color="Route of study", size="Satisfaction level", shape="Has dependents?")
```

Recalling a stored plot
========================================================



```r
 #Recall myPlot
myPlot
```

<img src="4_Graphs_and_Data_Visualisation-figure/unnamed-chunk-11-1.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" style="display: block; margin: auto;" />


Saving plots # 1
========================================================

- Plots can be save using the __export__ button in the plots tab

<img src="img/savePlot1.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" width="100%" style="display: block; margin: auto;" />

Plots can also be saved using code
========================================================

- You might want to include code to save your plot in a script, for example
- This can allow greater control over the output file and plot dimensions:

```r
ggsave(plot= myPlot, file="myPlot.pdf", width = 4, height = 4)
ggsave(plot= myPlot, file="myPlot.png", width = 4, height = 4, units="cm", dpi=320)
```



