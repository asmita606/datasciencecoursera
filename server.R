library(shiny)
shinyServer(function(input, output) {
  model1 <- lm(dist ~ speed, data = cars)
  model2 <- lm(dist ~ poly(speed,2), data = cars)

  model1pred <- reactive({
    speedInput <- input$sliderspeed
    predict(model1, newdata = data.frame(speed = speedInput))
  })

  model2pred <- reactive({
    speedInput <- input$sliderspeed
    predict(model2, newdata =
              data.frame(speed = speedInput))
  })
  output$plot1 <- renderPlot({
    speedInput <- input$sliderspeed

    plot(cars$speed, cars$dist, xlab = "Speed (mph)",
         ylab = "Stopping distance (ft)", bty = "n", pch = 16,
         xlim = c(0, 30), ylim = c(0, 120))
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    if(input$showModel2){
      model2lines <- predict(model2, newdata = data.frame(
        speed = 0:30))
      lines(0:30, model2lines, col = "blue", lwd = 2)
    }
    legend(0, 100, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16,
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(speedInput, model1pred(), col = "red", pch = 16, cex = 2)
    points(speedInput, model2pred(), col = "blue", pch = 16, cex = 2)
  })

  output$pred1 <- renderText({
    model1pred()
  })

  output$pred2 <- renderText({
    model2pred()
  })
})
