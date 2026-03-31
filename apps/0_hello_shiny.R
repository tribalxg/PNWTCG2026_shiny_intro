# Hello Shiny - Learn about the core components any Shiny App needs


# always need to load Shiny and any other packages the app requires
library(shiny)

# the user interface (UI) is the frontend of your app, where you build the app layout the user will see
ui = fluidPage()

# the server is the backend of your app, where R code does some work with inputs to produce outputs
# input and output are always first two arguments
server = function(input, output) {
  
}

# a call to `shinyApp` pulls everything together, always with ui and server as the first two arguments
shinyApp(ui, server)
