library(tidyverse)
library(zoo)
source("/workdir/R/control_chart.R")
team_name <- "Club Tijuana"
path_files <- list.files("data/ligaMX_2023-24/", "^wyscout", recursive = TRUE, full.names = TRUE)
data <- read_csv(path_files, show_col_types = FALSE) |>
  arrange(Date)
liga_mx <- data |>
  janitor::clean_names() |>
  distinct(date, match, team, .keep_all = TRUE) |>
  filter(stringr::str_detect(competition, "Mexico"))

random_xolos <- liga_mx |>
  filter(team == team_name) |>
  sample_frac(replace = TRUE) |>
  add_wheel_index(left_align = TRUE) |>
  select_wheel_index()

chart_xolos <- liga_mx |>
  filter(team == team_name) |>
  add_wheel_index() |>
  select_wheel_index()

