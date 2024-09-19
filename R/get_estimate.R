#' get_estimate
#' @import shiny
#'
#' @description
#' Launches the Used Cars Price Predictor v0.1 shiny app in default browser.
#'
#' @export
get_estimate <- function(){
  appDir <- system.file("get_estimate", package = "UsedCarsIndia")
  if (appDir == "") {
    stop("Could not find the directory. Try re-installing `UsedCarsIndia`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
