library(shiny)
shinyServer(
  function(input, output) {
    output$inputText <- renderPrint({input$inputText})
    output$prediction <- renderPrint({predict(input$inputText)})
  }
)