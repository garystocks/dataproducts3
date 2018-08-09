#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that plots 2 models
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Monthly Apple Stock Prices from 2007 to 2018"),
  p("The black line represents the smoothed monthly opening stock prices from January 2008 to January 2013 (year 0 is 2007). The blue line represents the forecasted opening monthly stock price for 24 months from February 2013 to January 2015. The green line represents the actual opening monthly stock price (test set) from January 2013 to August 2018."),
  br(),
  
  # Sidebar with a slider input for forecast month
  sidebarLayout(
    sidebarPanel(
       h3("Forecast Model Selections"),
       p("Use the slider to select the forecast month. Month 1 is February 2013, the first month of the forecast and month 24 is January 2015."),
       sliderInput("FMonth", "Pick Forecast Month", 1, 24, 1),
       checkboxInput("ShowTestFcast", "Show / Hide Test Data Forecast", value = TRUE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("plot1"),
       h5("Forecast Stock Price:"),
       textOutput("fcast"),
       h5("Actual Stock Price:"),
       textOutput("actual")
    )
  )
))
