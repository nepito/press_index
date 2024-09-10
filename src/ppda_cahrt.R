library(tidyverse)
library(zoo)
xolos <- read_csv("data/ligaMX_2023-24/Club_Tijuana.csv")
xolos_mx <- xolos |>
  janitor::clean_names() |>
  filter(stringr::str_detect(competition,"Mexico" ))

random_xolos <- xolos_mx |>
  filter(team == "Club Tijuana") |>
  sample_frac(replace = TRUE) |>
  mutate(
    central_p = passes_accurate*100/crosses_accurate,
    ppda_mean = zoo::rollapply(ppda, width = 4, mean, fill = NA, align="left"),
    tempo_mean = zoo::rollapply(match_tempo, width = 4, mean, fill = NA, align="left"),
    central_p_mean = zoo::rollapply(central_p, width = 4, mean, fill = NA, align="left")
  ) |>
  select(1:3,ppda_mean, tempo_mean, central_p_mean)

chart_xolos <- xolos_mx |>
  filter(team == "Club Tijuana") |>
  mutate(
    central_p = passes_accurate*100/crosses_accurate,
    ppda_mean = zoo::rollapply(ppda, width = 4, mean, fill = NA, align="left"),
    tempo_mean = zoo::rollapply(match_tempo, width = 4, mean, fill = NA, align="left"),
    central_p_mean = zoo::rollapply(central_p, width = 4, mean, fill = NA, align="left")
  ) |>
  select(1:3,ppda_mean, tempo_mean, central_p_mean)