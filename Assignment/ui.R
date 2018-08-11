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
  titlePanel("Monthly Apple Stock Prices"),
  p("The black line represents the smoothed monthly opening stock prices starting from 11 years ago and for a period of 10 years. The green line (if shown) is the test set, which are the actual stock prices for the past 20 months. The blue line represents the forecasted opening monthly stock price for the past 18 months and for the next 6 months."),
  br(),
  
  # Sidebar with a slider input for forecast month
  sidebarLayout(
    sidebarPanel(
       h3("Forecast Model Selections"),
       p("Use the slider to select the forecast month. Month 18 is the current month and month 24 is 6 months ahead."),
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
