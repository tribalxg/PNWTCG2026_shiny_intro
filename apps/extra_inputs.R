# Extra input types not covered in other apps

library(shiny)

ui <- fluidPage(
  passwordInput("password", 
                "Password Input"),
  textAreaInput("textarea", 
                "Text Area:"),
  numericInput("numeric", 
               "Numeric Input", 
               value=10, 
               step=10),
  sliderInput("slider", 
              "Slider Input", 
              value=c(2,3), 
              min=0, 
              max=5),
  dateInput("date", 
            "Choose a date"),
  dateRangeInput("date_range", 
                 "Choose a date range"),
  checkboxInput("checkbox", 
                "Check me", 
                value=TRUE),
  fileInput("file_upload", 
            "Upload a file"),
  actionButton("action", 
               "Action Button")
)

server <- function(input, output) {}

shinyApp(ui, server)


