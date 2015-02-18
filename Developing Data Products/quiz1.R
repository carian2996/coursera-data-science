# Ian Castillo Rosales
# Quizz 1 - Developing Data Products
# 06/02/2015

# ===== Question 1 =====
library(manipulate)
myPlot <- function(s) {
      plot(cars$dist - mean(cars$dist), cars$speed - mean(cars$speed))
      abline(0, s)
}

manipulate(myPlot(s), s = slider(0, 2, step = 0.1))

# ===== Question 4 =====
library(shiny)
shinyUI(pageWithSidebar(
      headerPanel("Data science FTW!"),
      sidebarPanel(
            h2('Big text')
            h3('Sidebar')
      ),
      mainPanel(
            h3('Main Panel text')
      )
))

shinyUI(pageWithSidebar(
      headerPanel("Example plot"),
      sidebarPanel(
            sliderInput('mu', 'Guess at the mu',value = 70, min = 60, max = 80, step = 0.05,)
      ),
      mainPanel(
            plotOutput('newHist')
      )
))