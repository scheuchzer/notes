library(shiny)
shinyUI(pageWithSidebar(
  headerPanel('Data Science FTW!'),
  sidebarPanel(
    h3('Sidebar Text'),
    numericInput('id1', 'Numeric input, labelled id1', 0, min=0, max=10, step=1),
    checkboxGroupInput('id2', "Checkbox", c("Value 1" = "1", "value 2" = "2")),
    dateInput('id3', "Date")
    
    ,
    numericInput('glucose', 'Glucose mg/dl', 90, min=50, max=200, step=5),
    #submitButton('Submit'),
    sliderInput('mu', 'Guess at the mean', value=70, min=62, max=74, step=0.05)
  ),
  mainPanel(
    h3('Result of prediction'),
    h4('You entered'),
    verbatimTextOutput('inputValue'),
    h4('Which resulted in a prediction of '),
    verbatimTextOutput('prediction'),
    plotOutput('newHist')
  )
))