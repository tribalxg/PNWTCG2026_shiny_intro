# Shiny Basics - now let's add an input and output, where the output changes based on the user input

library(shiny)

# we can place inputs and outputs into the user interface using functions provided by shiny
# all inputs and outputs have a unique identifier that is referenced when doing something in the server
ui = fluidPage(
  textInput(inputId = "myTextInput",        # first argument is always a unique identifier
            label = "What is your name?"),  # label the user will see
  textOutput(outputId = "myTextOutput")
)


server = function(input, output) {
  output$myTextOutput = renderText({        # define an ouput by assigning it to the output list
    paste("Hello,", input$myTextInput)      # use a render function following the format output$`ID` = render`Type`({ some computation })
  })
}

shinyApp(ui, server)