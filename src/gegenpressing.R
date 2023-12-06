library(tidyverse)
library(pression)
paths <- list.files("/workdir/", pattern = "_2023-24\\.csv$")
teams <- read_csv(paths, show_col_types = FALSE)
gegenpressing <- teams |>
  pression::calculate_ggpi()
