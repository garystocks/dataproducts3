Apple Stock Forecast
========================================================
author: Gary Stocks
date: 11 August 2018
autosize: true
font-family: 'Arial'
transition: rotate

Overview
========================================================

The objective of this model is to forecast the underlying trend in Apple stock prices to use to decide whether to invest in Apple stock for the long term.

This presentation describes how the data is prepared and used to build a forecast model. The interactive Shiny app has been published [here](https://garystocks.shinyapps.io/Assignment/). The full code to build the model can be found on github [here](https://github.com/garystocks/dataproducts3).

The model forecasts an upward trend in the Apple stock price. However, the actual stock prices for the preceding 18 months, used as test data, is much higher than the forecast values. This suggests the forecast model may be under-estimating the stock price which could be due to short-term factors and would need to be taken into account when deciding on the best time to invest.

Data Preparation
========================================================

The Apple stock data is sourced from Yahoo using the **getSymbols** function in the **quantmod** package. The data imported is the daily pricing for the current year to date and the previous 11 years.

The data is manipulated in the following way:
- Daily data is converted to monthly
- The opening monthly price is extracted
- The data is stored as a time series object
- Data for years 1 through 11 is used to train the forecast model
- The remaining data is used to test the model

Forecast Plot
========================================================

![plot of chunk unnamed-chunk-1](Apple Stock Forecast-figure/unnamed-chunk-1-1.png)

Explanation of Forecast Plot
========================================================

An exponential smoothing model was applied to the training time series data. A forecast model was then built on this exponential smoothing model. The forecast plot shows the Apple monthly opening stock prices from the exponential smoothing model (black line), the test data for the current year to date and previous year (green line), and the forecast prices for the previous 18 months and the 6 months ahead (blue line).


```r
price6m <- round(fcast$mean[24], 2)
```

The forecast of the Apple opening month balance for 6 months into the future is $127.08.
