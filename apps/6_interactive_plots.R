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
              selected="Bill, 2009"),
  plotlyOutput("wind_plotly"),
)

server = function(input, output, session) {
  
  stormdata = reactive({           
    s |>
      filter(name_year == input$storm_choice) |>
      arrange(date)
  })
  
  output$wind_plotly = renderPlotly({

    plot_ly(type = "scatter", 
            mode= "lines+markers") |>
      add_trace(
        data = stormdata(),
        x = ~date,
        y = ~wind,
        marker = list(size = 8),
        line = list(color = "blue", width = 2),
        hoverinfo = "text",
        hovertext = paste(
          "Date:",
          paste0(
            stormdata()$date
          ),
          "<br>",
          "Wind Speed:",
          paste0(
            stormdata()$wind
          ),
          "<br>",
          "Pressure:",
          paste0(
            stormdata()$pressure
          ),
          "<br>",
          "Storm status:",
          paste0(
            stormdata()$status
          ),
          "<br>"
        )
      ) |>
      layout(showlegend=FALSE)
  })
}

shinyApp(ui, server)
