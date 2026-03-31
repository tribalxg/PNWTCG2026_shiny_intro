# Dynamic User Interfaces - update UI based on selections from the user

suppressPackageStartupMessages({
  library(shiny)
  library(ggplot2)
  library(dplyr)
  library(leaflet)
  
})

s = storms |>
  mutate(date = as.POSIXct(sprintf("%s-%s-%s %s:00", year, month, day, hour))) 

ui = fluidPage(
  leafletOutput("storm_tracks"),
  selectInput("year", 
              "Choose a year", 
              choices=sort(unique(s$year))),
  selectInput("name",
              "Choose a storm",
              NULL),
)

server = function(input, output, session) {
  
  storms = reactive({
    s |>
      filter(year == input$year)
  })
  
  observeEvent(storms(), {                      #  input in UI updates when triggered by reactive expression changing
    choices = unique(storms()$name)
    updateSelectInput(session = session, 
                      inputId = "name", 
                      choices = choices)
  })
  
  storm = reactive({
    filter(storms(), name == input$name)
  })

  output$storm_tracks = renderLeaflet({
    leaflet(data=storm()) |> 
      addProviderTiles("Esri.WorldImagery") |>     # leaflet isn't married to using openstreetmap tiles
      addCircleMarkers(~long, ~lat)
  })
}

shinyApp(ui, server)
