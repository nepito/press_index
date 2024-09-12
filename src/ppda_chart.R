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

random_xolos <- liga_mx |>
  filter(team == "Club Tijuana") |>
  sample_frac(replace = TRUE) |>
  mutate(
    central_p = passes*100/crosses,
    ppda_mean = zoo::rollapply(ppda, width = 4, mean, fill = NA, align="left"),
    tempo_mean = zoo::rollapply(match_tempo, width = 4, mean, fill = NA, align="left"),
    possession_mean = zoo::rollapply(possession_percent, width = 4, mean, fill = NA, align="left"),
    central_p_mean = zoo::rollapply(central_p, width = 4, mean, fill = NA, align="left")
  ) |>
  select(1:3,ppda_mean, tempo_mean, central_p_mean, possession_mean)

chart_xolos <- liga_mx |>
  filter(team == "Club Tijuana") |>
  mutate(
    central_p = passes*100/crosses,
    ppda_mean = zoo::rollapply(ppda, width = 4, mean, fill = NA, align="right"),
    tempo_mean = zoo::rollapply(match_tempo, width = 4, mean, fill = NA, align="right"),
    possession_mean = zoo::rollapply(possession_percent, width = 4, mean, fill = NA, align="right"),
    central_p_mean = zoo::rollapply(central_p, width = 4, mean, fill = NA, align="right")
  ) |>
  select(1:3,ppda_mean, tempo_mean, central_p_mean, possession_mean)