---
output:
  word_document: default
  pdf_document: default
  html_document: default
editor_options: 
  markdown: 
    wrap: 72
---

# Moderation analysis
timeInCounselling_centred
# Overview

-   What are mediation and moderation?
-   Moderation analysis in more detail
-   Grand Mean Centering
-   Checking Assumptions
-   Interpreting Moderation
-   Bootstrapping Moderation

# What are mediation and moderation?

type: section

# What is moderation?

There is a direct relationship between X and Y but it is affected by a
moderator (M)

```{r  out.height = "75%", echo=F, warning=F, message=F}
library(DiagrammeR)
edf <-
  create_edge_df(
    from = c(1,2),
    to = c(4,3),
    color="black",
    # label = c(" ","-","+"),
    fontsize=16)

ndf <- create_node_df(
  n=4,
  label = c("Time in \n counselling", "Rapport with \n counsellor", "", "General Wellbeing"),
  shape = c("rectangle","rectangle","point","rectangle" ), 
  fillcolor = "white", 
  width = c(1.5,1.5,0,1.5), 
  height = c(1,1,0,1),
  x=c(1,3,3,5), 
  y=c(1,2,1,1),
  fontsize=12,
  color="black",
  fontcolor="black")

mod_graph <-
  create_graph(nodes_df = ndf, edges_df = edf)


mod_graph %>% render_graph(title = " ")

```

In the above model, we theorise that Time in counselling predicts
General Wellbeing but the strength of the relationship is affected by
the level of Rapport with counsellor

# What packages do we need?

-   **gvlma** (for checking assumptions)
-   **interactions** (for generating interaction plot)
-   **Rockchalk** (for testing simple slopes)
-   **car** (includes a **Boot()** function to bootstrap regression
    models )

# What is moderation?

-   The relationship between a predictor (X) and outcome (Y) is affected
    by another variable (M)
-   This is referred to as an interaction (similar to interaction in
    standard regression)
-   A moderator can effect the direction and/or strength of a
    relationship between X and Y

```{r echo=F}
mod_graph %>% render_graph(title = " ")
```

Here we might find that the relationship between Time in counselling and
General Wellbeing is strong for those who have a strong rapport with
their counselling psychologist and weak for those who do not have good
rapport with their counselling psychologist.

# What is moderation? \#2

-   Very similar to multiple regression

    lm(Y \~ X + M + X\*M)

-   Moderation analysis includes X, M and the interaction between X and
    M

-   If we find a moderation effect it becomes the focus of our analysis
    (the independent role of X and M becomes less important)

# What is moderation? \#3

```{r echo = F, out.width = "60%"}
#setwd("location") #Working directory
set.seed(123)#Standardizes the numbers generated by rnorm; see Chapter 5
N  <- 100 #Number of participants; graduate students
timeInCounselling  <- abs(rnorm(N, 6, 4)) #IV; 
X1 <- abs(rnorm(N, 60, 30)) #Adding some systematic variance for our DV
rapportLevel  <- rnorm(N, 4, 8) #Moderator; years in education
generalWellbeing  <- abs((0.8*-timeInCounselling) * (.1*rapportLevel) + -0.8*timeInCounselling + -0.4*X1 + 10 + rnorm(N, 0, 3)) #DV; 
Moddata <- data.frame(timeInCounselling, rapportLevel, generalWellbeing)


#Moderation "By Hand" with centred data
library(gvlma)
fitMod <- lm(generalWellbeing ~ timeInCounselling *rapportLevel , data = Moddata) #Model interacts IV & moderator

library(interactions)
 ip <- interact_plot(fitMod, pred = timeInCounselling, modx = rapportLevel)
 ip
```

In the plot above: - The blue line is the "standard" regression line -
The black line is when the moderator is "low" (-1sd) - The dotted line
is when the moderator is "high" (+1sd)

# Moderation: step-by-step

type: section

# Step 1: Grand Mean Centering

-   Regression coefficients (b values) are based on predicting Y when X
    = 0

-   Not all measures actually have a zero value

-   To make results easier to interpret, we can centre our data around
    the grand mean of the data (making the mean 0)

    -   The mean of the full sample is subtracted from the value

-   This is similar to z-score (i.e. a standardised score)

To do this in R, we can use the **scale()** function:

    Xc    <- scale(X, center=TRUE, scale=FALSE) #Centering X; 
    Mc    <- scale(M,  center=TRUE, scale=FALSE) #Centering M;

We then use the centred data in our analysis

# Step 1: Grand Mean Centering \#2

## We can see that the difference between the original data is the mean of the data.

```{r echo = T}
#Centering Data
Moddata$timeInCounselling_centred    <- c(scale(timeInCounselling, center=TRUE, scale=FALSE)) 

#Centering IV; 
Moddata$rapportLevel_centred    <- c(scale(rapportLevel,  center=TRUE, scale=FALSE)) #Centering moderator; 

#Moderation "By Hand" with centred data
library(gvlma)
fitMod <- lm(generalWellbeing ~ timeInCounselling_centred *rapportLevel_centred  , data = Moddata) #Model interacts IV & moderator

library(interactions)
 ip <- interact_plot(fitMod, pred = timeInCounselling_centred, modx = rapportLevel_centred)
 ip
```

# Do I need to mean centre my data?

It is worth noting:

-   It does not change the results of your interaction (coefficient,
    standard error or significance tests).
-   It will change the results of the direct effects (the individual
    predictors in your model).
-   It is a step that tries to ensure that the coefficients of the
    predictor and moderator are meaningful in relation to each other.
-   In some cases, it might not be necessary to mean centre at all.
    However, there is no harm in doing so, and it could potentially be
    helpful.

Hayes (2013) discusses mean centering, pp. 282-290.

McClelland, G. H., Irwin, J. R., Disatnik, D., & Sivan, L. (2017).
Multicollinearity is a red herring in the search for moderator
variables: A guide to interpreting moderated multiple regression models
and a critique of Iacobucci, Schneider, Popovich, and Bakamitsos (2016).
Behavior research methods, 49(1), 394-402.

# Step 2: Check assumptions

## We can use the gvlma function to check regression assumptions

```{r}

library(gvlma)
gvlma(fitMod)
```

The "global stat" is an attempt to check multiple assumptions of linear
model: Pena, E. A., & Slate, E. H. (2006). Global validation of linear
model assumptions. Journal of the American Statistical Association,
101(473), 341-354.

Since one of the underlying assumptions is violated, the overall stat is
also not acceptable.

The data looks skewed, we should transform it or perhaps use
bootstrapping

# Step 3: Moderation Analysis

```{r}

fitMod <- lm(generalWellbeing ~ timeInCounselling_centred *rapportLevel_centred  , data = Moddata) #Model interacts IV & moderator
 #Model interacts IV & moderator
summary(fitMod)
```

The results above show that there is a moderated effect

# Step 3: Moderation analysis \#2

We use an approach called **simple slopes** to visualise the moderation
effect

        interact_plot(fitMod, pred = timeInCounselling_centred, modx = rapportLevel_centred)

```{r echo=F}
ip
 
```

# Step 3: Moderation analysis \#3

The **rockchalk** package includes useful functions for visualising
simple slopes

```{r}
library(rockchalk)

fitMod <- lm(generalWellbeing ~ timeInCounselling *rapportLevel  , data = Moddata)
summary(fitMod)
slopes <- plotSlopes(fitMod, modx = "rapportLevel", plotx = "timeInCounselling")
testSlopes <- testSlopes(slopes)
plot(testSlopes)


```

# Step 4: Bootstrapping

## The **car** package includes a function to bootstrap regression

```{r}
library(car)

bootstrapModel <- Boot(fitMod, R=999)

confint(fitMod)
confint(bootstrapModel)
summary(bootstrapModel)
hist(bootstrapModel)
```

# Summary

-   Revision: What are mediation and moderation?
-   Moderation analysis in more detail
-   Grand Mean Centering
-   Checking Assumptions
-   Interpreting Moderation
-   Bootstrapping Moderation