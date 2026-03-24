# Dynamic plots - plot some data based on user specified fields

library(shiny)
library(dplyr)

s = storms

ui = fluidPage(
  # Select variable for x-axis
  selectInput(inputId = "x_var", 
              label = "X Variable", 
              choices = c("year","month", "lat", "wind", "pressure"),
              selected="wind"),                   # add a default selection
  
  # Select variable for y-axis
  selectInput(inputId = "y_var", 
              label = "Y Variable", 
              choices=c("Year" = "year",          # Can use named choices for a nicer appearance in the UI
                        "Month" = "month", 
                        "Latitude" = "lat", 
                        "Wind" = "wind", 
                        "Pressure" = "pressure"),
              selected="lat"),
  
  plotOutput("plot")
)

server = function(input, output) {
  
  output$plot = renderPlot({
    plot(x=s[[input$x_var]], y=s[[input$y_var]]) 
  })
  
}

shinyApp(ui, server)