# Reactive Expressions - learn how to define an expression that will change based on an event

suppressPackageStartupMessages({
  library(shiny)
  library(ggplot2)
  library(dplyr)
  library(leaflet)
})

s <- storms |>
  mutate(date = as.POSIXct(sprintf("%s-%s-%s %s:00", year, month, day, hour)),
         name_year = paste(name, year, sep=", ")) 

ui <- fluidPage(
  selectInput("storm_choice",
              "Choose a storm to plot",
              choices=sort(unique(s$name_year)),
              selected="Hugo"),
  actionButton("go", "GO!"),
  plotOutput("wind_plot"),
  leafletOutput("storm_track")
)

server <- function(input, output, session) {
  
  stormdata <- eventReactive(input$go, {           # define reactive expressions that are triggered by 
    s |>                                           # an event as `name` = eventReactive(event, { `expression` })
      filter(name_year == input$storm_choice) |>
      arrange(date)
  })
  
  output$wind_plot = renderPlot({
    ggplot(stormdata(), aes(x=date)) +              # call the expression like a function by its name 
      geom_line(aes(y=wind)) 
  })
  
  output$storm_track = renderLeaflet({              # leaflet is a basic mapping library we can plot points on
    leaflet(data=stormdata()) |>                    # we can refer to it as many times as we want
      addTiles() |>
      addCircleMarkers(~long, ~lat)
  })
}

shinyApp(ui, server)
