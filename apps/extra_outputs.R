# Extra output types not covered in other apps

suppressPackageStartupMessages({
  library(shiny)
  library(dplyr)
  library(ggplot2)
  
  library(DT)                                   # for rendering dynamic data tables and outputting them
})

s = storms 

ui = fluidPage(
  verbatimTextOutput("summary"), 
  tableOutput("table"),
  DTOutput("dtable"),
  imageOutput("image")
)

server = function(input, output) {
  
  output$summary = renderPrint(summary(s))     # similar to print()
  
  output$table = renderTable(head(s))          # for static tables
  
  output$dtable = DT::renderDT(s)              # for dynamic tables
  
  output$image = renderImage({
    list(src = "www/txg_logo.png",              # /www must live in the same level as your app.R (or ui.R and server.R) file
         contentType = 'image/jpg',
         width = 150,
         height = 150,
         alt = "This is alternate text")})
}

shinyApp(ui = ui, server = server)
