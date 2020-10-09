#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(Hmisc)
se <- function(x) sqrt(var(x)/length(x))
ci <- function(m,n) { qt(.95, df=n-1)*se(m) }

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("The effect of Sample Size, Mean and SD on the significance of the difference between groups"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        
        sliderInput("number", label = "Number of participants per group:",
                    min = 10, max = 1000, value = 50, step = 10),
        sliderInput("g1_mean", label = "Mean of group 1:",
                    min = 1, max = 100, value = 50, step = 1),
        sliderInput("g1_sd", label = "Standard deviation of group 1:",
                    min = 1, max = 10, value = 5, step = 1), 
        sliderInput("g2_mean", label = "Mean of group 2:",
                    min = 1, max = 100, value = 70, step = 1),
        
        sliderInput("g2_sd", label = "Standard deviation of group 2:",
                    min = 1, max = 10, value = 10, step = 1)
        
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("myPlot"),
         verbatimTextOutput("myt")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
 myData <- reactive({
   
   n <- input$number
   group1 <-  rep(1, n)
   group1Time <- rnorm(n, input$g1_mean, input$g1_sd)
   group2 <- rep(2,n)
   group2Time <- rnorm(n, input$g2_mean, input$g2_sd)
   group <- c(group1,group2)
   time <- c(group1Time, group2Time)
   hdata <- as.data.frame(cbind(group, time))
   hdata
 })
   
  output$myPlot <- renderPlot({
    
    myxlims <- c(min(myData()$time), max(myData()$time))
    
    p1 <- ggplot(myData(), aes(x=time, fill=as.factor(group))) + geom_histogram()  + theme(legend.position="none") + xlim(myxlims) + ggtitle("Histogram showing Group 1 and Group 2") + xlab("Time") + ylab("Frequency")
    
    p2 <- ggplot(myData(), aes(as.factor(group), time, colour=as.factor(group))) + stat_summary(fun.y = "mean", geom = "point") + stat_summary(geom="errorbar", fun.data=mean_cl_normal, width=0.1, conf.int=0.95) + coord_flip(ylim = c(myxlims)) + ggtitle("Confidence intervals of the mean") + xlab("Group") + ylab("Time") + theme(legend.position="none")
    
    
    
    gridExtra::grid.arrange(p1,p2, ncol=1)
    
  })
  
  output$myt <- renderPrint ({
    
    t.test(myData()$time~myData()$group)
    
  })
  
 
}

# Run the application 
shinyApp(ui = ui, server = server)

