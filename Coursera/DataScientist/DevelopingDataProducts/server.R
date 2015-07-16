library(shiny)
library(UsingR)
data(galton)

diabetesRisk <- function(glucose) glucose/200

shinyServer(
  function(input, output) {
    x <- reactive({diabetesRisk(input$glucose)})
    
    output$inputValue <- renderPrint({input$glucose})
    output$prediction <- renderPrint(x())
    
    output$newHist <- renderPlot({
      hist(galton$child, xlab='child height', col='lightblue', name='Histogram')
      mu <- input$mu
      
      lines(c(mu, mu), c(0,200), col='red', lwd=5)
      mse <- mean((galton$child - mu)^2)
      text(63, 150, paste('mu = ', mu))
      text(63, 140, paste('MSE = ', mse))
    })
  }
)