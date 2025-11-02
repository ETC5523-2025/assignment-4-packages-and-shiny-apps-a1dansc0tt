library(usethis)
library(dplyr)
library(purrr)
library(readr)

#Location of CSVs
csv_folder <- "data-raw" #pathway to CSVs

#List of all CSVs
csv_files <- list.files(
  path = csv_folder,
  pattern = "^20.*\\.csv$",  # regular expression: starts with 20 and ending with .csv
  full.names = TRUE
)

#Combine all CSVs
clean_data <- csv_files %>%
  map_dfr(read_csv)

#Set to default data
usethis::use_data(clean_data, overwrite = TRUE)
