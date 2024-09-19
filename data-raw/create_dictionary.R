

dictionary <- data.frame(columns = c("make", "model", "variant", "year", "transmission", "bodyType", "fuelType",
                                     "ownerNumber", "odometerReading", "cityRto", "listingPrice", "fitnessUpto",
                                     "insuranceType", "duplicateKey", "city", "registrationYear", "registrationMonth"),
                         short_definition = c("Car Brand or Manufacturing Company",
                                      "Name of Car Model", "Name of car variant", "Year when Car Model was launched",
                                      "Type of Gear System (Manual/Automatic)", "Type of Car (SUV/Sedan/Hactback etc.)",
                                      "Type of Fuel (Petrol/Diesel/Electric etc.)", "Number of Previous Owners",
                                      "Distance travelled (in Kilometers)", "RTO where car is registered",
                                      "Price of Car (in ₹)", "Fitness Certificate Validity End Date",
                                      "Type of Insurance Coverage", "Is Duplicate Key Available?",
                                      "City/Region where car is available", "Year of Registration",
                                      "Month of Registration"),
                         column_order = 1:17)

usethis::use_data(dictionary, overwrite = TRUE)

