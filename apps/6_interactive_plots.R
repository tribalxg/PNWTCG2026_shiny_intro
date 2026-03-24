# Interactive data visualization with plotly

suppressPackageStartupMessages({
  library(shiny)
  library(dplyr)
  library(plotly)
})

s = storms |>
  mutate(date = as.POSIXct(sprintf("%s-%s-%s %s:00", year, month, day, hour)),
         name_year = paste(name, year, sep=", "))

ui = fluidPage(
  selectInput("storm_choice",
              "Choose a storm to plot",
              choices=unique(s$name_year),
              selected="Hugo"),
  plotlyOutput("wind_plotly"),
)

server = function(input, output, session) {
  
  stormdata = reactive({           
    s |>
      filter(name_year == input$storm_choice) |>
      arrange(date)
  })
  
  output$wind_plotly = renderPlotly({
    plot_ly(data = stormdata(),
            x = ~date,
            y = ~wind,
            type = "scatter",
            mode = "lines+markers")
  })
}

shinyApp(ui, server)
