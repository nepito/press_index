library(tidyverse)
library(pression)
teams <- read_csv("/workdir/xG_build-up_ppda_tilt_39_2023-24.csv", show_col_types = FALSE)
gegenpressing <- teams |>
  pression::calculate_ggpi()
