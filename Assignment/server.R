#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Create forecast model 
  library(forecast)
  library(quantmod)
  e <- new.env()
        
  # Get Apple stock ticker data
  AAPL <- getSymbols("AAPL", src = "yahoo", env = NULL)
        
  # Summarise monthly stock prices
  mAPPL <- to.monthly(AAPL)
        
  # Get the opening stock price each month
  APPL_Open <- Op(mAPPL)
        
  # Store as a time series object
  ts1 <- ts(APPL_Open, frequency = 12)
        
  # Create training and test sets
  ts1Train <- window(ts1, start = 1, end = 11)
  ts1Test <- window(ts1, start = 11, end = 13)
        
  # Apply exponential smoothing
  ets1 <- ets(ts1Train, model = "MMM")
        
  # Forecast
  fcast <- forecast(ets1)
  
  modelfcast <- reactive({
          monthInput <- input$FMonth
          fcast$mean[monthInput]
  })
  
  # Create output plot      
  output$plot1 <- renderPlot({
          
          # Draw forecast plot
          plot(fcast, main = "", xlab = "Year", ylab = "Opening Stock Price ($)", bty = "n", pch = 16, xlim = c(0, 13), ylim = c(0, 250))

          plotpoint <- reactive({
                  x <- input$FMonth
                  y <- modelfcast()
                  
          })
          
          points(11 + input$FMonth / 12, modelfcast(), col = "red", pch = 16, cex = 2)
          
          # Draw a red line with the test data forecast if selected
          if(input$ShowTestFcast) {
                  lines(ts1Test, col = "green", lwd = 2)
          }
          
  })
  
  # Display forecast stock price
  output$fcast <- renderText({
          round(modelfcast(), 2)
  })
  
  # Display actual stock price
  output$actual <- renderText({
          round(ts1Test[input$FMonth], 2)
  })
  
})
