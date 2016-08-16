library(shiny)
shinyUI(
  pageWithSidebar(
  headerPanel("Data Science - Capstone Project"),
  sidebarPanel(
    textInput('inputText', 'Text to be Predicted', ''),
    submitButton('Submit')
  ),
  mainPanel(
    h3('Results of prediction'),
    h4('You entered'),
    verbatimTextOutput("inputText"),
    h4('Predicted Next Word(s): '),
    verbatimTextOutput("prediction")
  )
))