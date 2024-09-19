#' @title Used Cars data
#'
#' @description
#' This dataset was created by extracting available used car data on Cars24 and Carwale websites.
#' Data was extracted between May 2024 and September 2024. This dataset also has labels which are visible when you use \code{View} to see the data.
#'
#' @format A \code{tibble} containing 17 columns and 10,233 rows.
#' \describe{
#' \item{make}{Car Brand or Manufacturing Company}
#' \item{model}{Name of Car Model}
#' \item{variant}{Name of car variant}
#' \item{year}{Year when Car Model was launched}
#' \item{transmission}{Type of Gear System (Manual/Automatic)}
#' \item{bodyType}{Type of Car (SUV/Sedan/Hactback etc.)}
#' \item{fuelType}{Type of Fuel (Petrol/Diesel/Electric etc.)}
#' \item{ownerNumber}{Number of Previous Owners}
#' \item{odometerReading}{Distance travelled (in Kilometers)}
#' \item{cityRto}{RTO where car is registered}
#' \item{listingPrice}{Price of Car (in ₹)}
#' \item{fitnessUpto}{Fitness Certificate Validity End Date}
#' \item{insuranceType}{Type of Insurance Coverage}
#' \item{duplicateKey}{Is Duplicate Key Available?}
#' \item{city}{City/Region where car is available}
#' \item{registrationYear}{Year of Registration}
#' \item{registrationMonth}{Month of Registration}
#' }
"usedcars"
