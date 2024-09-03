library(tidyverse)
library(jsonlite)
dp <- fromJSON("data/datapackage.json")
names_from_dp <- dp$resources$schema$fields[[1]]$name
root_path <- "/workdir/data/ligaMX_2023-24/2024-25"
files <- list.files(root_path, pattern = ".csv$", full.names = TRUE)
data <- read_csv(files, show_col_types = FALSE, col_names = names_from_dp, skip = 1) |>
  filter(!is.na(Match), Competition == "Mexico. Liga MX") |>
  distinct(Date, Match, Team, .keep_all = TRUE) |>
  write_csv(glue::glue("{root_path}/wyscout_matches.csv"))
