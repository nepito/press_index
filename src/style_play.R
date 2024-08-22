library(tidyverse)
library(jsonlite)
dp <- fromJSON("data/ligaMX_2023-24/datapackage.json")
names_from_dp <- dp$resources$schema$fields[[1]]$name
files <- list.files("/workdir/data/ligaMX_2023-24", pattern = ".csv$")
path_files <- glue::glue("/workdir/data/ligaMX_2023-24/{files}")
data <- read_csv(path_files, show_col_types = FALSE, col_names = names_from_dp, skip = 1) |>
  filter(!is.na(Match), Competition == "Mexico. Liga MX") |>
  distinct(Date, Match, Team, .keep_all = TRUE)
