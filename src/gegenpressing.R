library(tidyverse)
library(pression)
paths <- "xG_build-up_ppda_tilt_78_2024_2023-24.csv"
teams <- read_csv(paths, show_col_types = FALSE)
gegenpressing <- teams |>
  pression::calculate_ggpi() |>
  select(-c(offe_tran_n, build_up_disruption_n, ppda_n, delta_n)) |>
  write_csv("pression_index_bundesliga.csv")
