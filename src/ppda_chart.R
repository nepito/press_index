library(tidyverse)
library(zoo)
team_name = "Club Tijuana"
path_files <- list.files("data/ligaMX_2023-24/", "^wyscout", recursive = TRUE, full.names = TRUE)
data <- read_csv(path_files, show_col_types = FALSE) |>
  arrange(Date)
liga_mx <- data |>
  janitor::clean_names() |>
  distinct(date, match, team, .keep_all = TRUE) |>
  filter(stringr::str_detect(competition,"Mexico" ))

add_wheel_index <- function(league_data, left_align = FALSE) {
  how_align <- "right"
  if (left_align) {how_align <- "left"}
  league_data_with_wheel_index <- league_data |>
    mutate(
      central_p = passes*100/crosses,
      ppda_mean = zoo::rollapply(ppda, width = 4, mean, fill = NA, align=how_align),
      tempo_mean = zoo::rollapply(match_tempo, width = 4, mean, fill = NA, align=how_align),
      possession_mean = zoo::rollapply(possession_percent, width = 4, mean, fill = NA, align=how_align),
      central_p_mean = zoo::rollapply(central_p, width = 4, mean, fill = NA, align=how_align)
    )
  return(league_data_with_wheel_index)
}

random_xolos <- liga_mx |>
  filter(team == "Club Tijuana") |>
  sample_frac(replace = TRUE) |>
  add_wheel_index(left_align = TRUE) |>
  select(1:3,ppda_mean, tempo_mean, central_p_mean, possession_mean)

chart_xolos <- liga_mx |>
  filter(team == "Club Tijuana") |>
  add_wheel_index() |>
  select(1:3,ppda_mean, tempo_mean, central_p_mean, possession_mean)