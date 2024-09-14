library(tidyverse)
source("/workdir/R/control_chart.R")

rivals_data <- data <- read_csv("chart_points_from_rivals_metrics.csv", show_col_types = FALSE)
team_data <- data <- read_csv("chart_points_from_team_metrics.csv", show_col_types = FALSE)

points_all_metrics <- team_data |>
  left_join(rivals_data, by = c("date", "match", "competition")) |>
  mutate(
    tilt_field = (100 * passes_to_final_third) / (passes_to_final_third + rivals_passes_to_final_third),
    tilt_field_mean = .roll_mean(tilt_field, "right")
  ) |>
  select(-c(passes_to_final_third, rivals_passes_to_final_third, tilt_field))

rivals_data <- data <- read_csv("limits_from_rivals_metrics.csv", show_col_types = FALSE)
team_data <- data <- read_csv("limits_from_team_metrics.csv", show_col_types = FALSE)

limits_all_metrics <- team_data |>
  left_join(rivals_data, by = c("date", "match", "competition")) |>
  mutate(
    tilt_field = (100 * passes_to_final_third) / (passes_to_final_third + rivals_passes_to_final_third),
    tilt_field_mean = .roll_mean(tilt_field, "left")
  ) |>
  select(-c(passes_to_final_third, rivals_passes_to_final_third, tilt_field))
