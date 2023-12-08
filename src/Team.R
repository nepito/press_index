library(tidyverse)
library(RcppRoll)
library(latex2exp)

Team <- R6::R6Class("Team", list(
  raw_data = NULL,
  m = NULL,
  s = NULL,
  team_name = NULL,
  control_chart = NULL,
  initialize = function(path, team_name) {
    self$team_name <- team_name
    private$read_raw_data(path)
    private$calculate_random()
    private$calculate_mean()
    private$calculate_sd()
  },
  calculate_control_chart = function() {
    self$control_chart <- self$raw_data |>
      mutate(
        mean_dG_xG = roll_mean(dG_xG, 4, align = "left", fill = NA),
        over = mean_dG_xG > (self$m + self$s),
        under = mean_dG_xG < (self$m - self$s)
      ) |>
      select(1, 2, dG_xG, mean_dG_xG, over, under)
  }
),
private = list(
  unsorted_data = NULL,
  read_raw_data = function(path) {
    self$raw_data <- read_csv(path, show_col_types = FALSE) |>
      filter(Team == self$team_name) |>
      mutate(dG_xG = Goals - xG)
  },
  calculate_mean = function() {
    self$m <- private$unsorted_data |>
      mean()
  },
  calculate_sd = function() {
    self$s <- private$unsorted_data |>
      sd()
  },
  calculate_random = function() {
    private$unsorted_data <- self$raw_data %>%
      .$dG_xG |>
      sample(2000, replace = T) |>
      roll_mean(4, align = "right")
  }
)
)

plot_control_chart <- function(team) {
  new_order <- seq(nrow(team$raw_data), 1)
  labels <- team$raw_data$Match[new_order]
  cc <- ggplot(data = team$control_chart, aes(x = Date, y = mean_dG_xG)) +
    geom_point(color = "#00AFBB", size = 2) +
    geom_hline(yintercept = team$m, color = "green") +
    geom_hline(yintercept = team$m + 1 * team$s, color = "yellow") +
    geom_hline(yintercept = team$m - 1 * team$s, color = "yellow") +
    geom_hline(yintercept = team$m + 2 * team$s, color = "orange") +
    geom_hline(yintercept = team$m - 2 * team$s, color = "orange") +
    geom_hline(yintercept = team$m + 3 * team$s, color = "red") +
    geom_hline(yintercept = team$m - 3 * team$s, color = "red") +
    ggtitle(team$team_name)
  cc +
    xlab("") +
    ylab("G-xG") +
    scale_x_discrete(label = labels) +
    theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
    theme(panel.background = element_rect(fill = "white", colour = "grey50"))
}

liv <- Team$new("/workdir/data/premier/Liverpool.csv", "Liverpool")
liv$calculate_control_chart()

plot_control_chart(liv)
