library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict Stopping distance (ft) from Speed(mph)"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderspeed", "What is the Speed (mph) of the car?", 4, 25, value = 15),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
    ),
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted Stopping distance (ft) from Model 1:"),
      textOutput("pred1"),
      h3("Predicted Stopping distance (ft) from Model 2:"),
      textOutput("pred2")
    )
  )
))
