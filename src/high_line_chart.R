library(jsonlite)
library(tidyverse)
library(zoo)
source("/workdir/R/control_chart.R")
dp <- fromJSON("data/datapackage.json")
names_from_dp <- dp$resources$schema$fields[[1]]$name
team_name <- "Club Tijuana"
path_files <- list.files("data/ligaMX_2023-24/", "^wyscout", recursive = TRUE, full.names = TRUE)
data <- read_csv(path_files, show_col_types = FALSE, col_names = names_from_dp, skip = 1) |>
  arrange(Date)
liga_mx <- data |>
  janitor::clean_names() |>
  distinct(date, match, team, .keep_all = TRUE) |>
  filter(stringr::str_detect(competition, "Mexico"))

random_xolos <- liga_mx |>
  filter_rivals_data_of_team(team_name) |>
  sample_frac(replace = TRUE) |>
  add_wheel_index_from_rivals(left_align = TRUE) |>
  rivals_select_wheel_index() |>
  write_csv("limits_from_rivals_metrics.csv")

chart_xolos <- liga_mx |>
  filter_rivals_data_of_team(team_name) |>
  add_wheel_index_from_rivals(left_align = TRUE) |>
  rivals_select_wheel_index() |>
  write_csv("chart_points_from_rivals_metrics.csv")
