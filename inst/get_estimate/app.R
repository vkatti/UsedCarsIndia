#' @title Used cars Price Prediction v0.1
#' @name ShinyApp
#' @description
#' This shiny app uses a pre-trained Random Forest model to predict used car prices
#' The model predicts the listingPrice based on the variant + year + odometerReading + fuelType +
#' bodyType + transmission variables. This shiny app will provide a UI interface so user can select the values for  all these fields and
#' the model will predict the value and display the same.


library(shiny)
library(randomForest)

data_path <- system.file("data", package = "UsedCarsIndia")
print("this is from the app.R")
print(data_path)
load(file.path(data_path, "usedcars.rda"))
load(file.path(data_path, "rf_model.rda"))

input_data <- usedcars[!is.na(usedcars$fuelType), ]
input_data$make_model <- paste(input_data$make, input_data$model)

se <- round(floor(sqrt(mean(rf_model$mse))/1E4)*1E4,0)

ui <- fluidPage(
  titlePanel("Used Cars Price Predictor v0.1"),
  fluidRow(
    column(width = 4,
           selectizeInput("make_model", "Make - Model", choices = sort(unique(input_data$make_model))),
           selectizeInput("variant", "Variant", choices = NULL),
           selectInput("year","Model Year", choices = NULL),
           selectInput("fuelType","Fuel Type", choices = NULL),
           selectInput("bodyType","Body Type", choices = NULL),
           selectInput("transmission","Transmission", choices = NULL),
           sliderInput("odometerReading", "Odometer Reading", min = 500, max = 10000, value = 500, step=1000),
           actionButton("predict","Show Estimate")
           ),
    column(width=8,
           "The estimated price of the used car is:",
           h1(textOutput("predicted_price")),
           plotOutput("variant_plot")
        )
  )
)

server <- function(input, output, session) {



  output$variant_plot <- renderPlot({

    input_data[input_data$variant == input$variant & !is.na(input_data$fuelType), ] |>
      ggplot2::ggplot() +
      ggplot2::facet_wrap("fuelType", drop = TRUE) +
      ggplot2::geom_point(ggplot2::aes(x = odometerReading, y = listingPrice, color = factor(year, levels = 2000:2024)), size=3) +
      ggplot2::geom_smooth(ggplot2::aes(x = odometerReading, y = listingPrice), method = "lm") +
      ggplot2::geom_point(ggplot2::aes(x = odometerReading, y = estimated_price(), color = factor(year, levels = 2000:2024)), pch=13, size=5, data = new_data()) +
      ggplot2::labs(x = "Odometer Reading (in Kms)", color = "Model Year") +
      ggplot2::theme_bw() +
      ggplot2::theme(legend.position = "top",
            legend.direction = "horizontal")
  }) |> bindEvent(input$predict)

  new_data <- reactive({
    data.frame(variant = input$variant,
               year = input$year,
               fuelType = input$fuelType,
               bodyType = input$bodyType,
               transmission = input$transmission,
               odometerReading = input$odometerReading
               )
  }) |> bindEvent(input$predict)

  estimated_price <- reactive({
    predict(rf_model, new_data())
  })

  output$predicted_price <- renderText({
    paste0("₹ ", round(estimated_price(),0)," +/- ", se)
  })


  variant_choices <- reactive({
    sort(unique(input_data$variant[input_data$make_model == input$make_model]))
  })  |>  bindEvent(input$make_model)

  year_choices <- reactive({
    sort(unique(input_data$year[input_data$make_model == input$make_model & input_data$variant == input$variant]))
  }) |> bindEvent(input$variant)

  fuelType_choices <- reactive({
    sort(unique(input_data$fuelType[input_data$make_model == input$make_model &
                                      input_data$variant == input$variant]))
  }) |> bindEvent(input$variant)

  bodyType_choices <- reactive({
    sort(unique(input_data$bodyType[input_data$make_model == input$make_model &
                                      input_data$variant == input$variant]))
  }) |> bindEvent(input$variant)

  transmission_choices <- reactive({
    sort(unique(input_data$transmission[input_data$make_model == input$make_model &
                                          input_data$variant == input$variant]))
  }) |> bindEvent(input$variant)

  odo_max <- reactive({
    as.integer((max(input_data$odometerReading, na.rm = TRUE)/1E4)*1E4)
  })

    # Set Variant
  observe({
    updateSelectizeInput(
      session, inputId = "variant",
      choices = sort(variant_choices()))
  })

  # Set Year
  observe({
    updateSelectizeInput(
      session, inputId = "year",
      choices = year_choices())
  })

  # Set Fuel Type
  observe({
    updateSelectizeInput(
      session, inputId = "fuelType",
      choices = fuelType_choices())
  })

  # Set Body Type
  observe({
    updateSelectizeInput(
      session, inputId = "bodyType",
      choices = bodyType_choices())
  })

  # Set Transmission
  observe({
    updateSelectizeInput(
      session, inputId = "transmission",
      choices = transmission_choices())
  })

  # Set odo
  observe({
    updateSliderInput(
      session, inputId = "odometerReading",
      max = odo_max(),
      value = odo_max()/2)
  })

}

shinyApp(ui, server)

