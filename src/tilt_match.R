library(tidyverse)
library(jsonlite)
library(wstools)

names <- c("Liverpool", "Chelsea", "Manchester City", "Tottenham Hotspur", "Arsenal", "Brighton")

all_team_stats <- list()
for (team in names) {
  team_name <- str_replace(team, " ", "_")
  path <- glue::glue("/workdir/data/{team_name}.csv")
  team_stats <- read_team_stats(path) |>
    filter_premier_league() |>
    add_tilt() |>
    filter(Team == team)
  all_team_stats[[team]] <- team_stats
}
all_team_tilt <- list()
for (team in names(all_team_stats)) {
  all_team_tilt[[team]] <- quantile(all_team_stats[[team]]$tilt)
}
ListJSON <- toJSON(all_team_tilt, pretty = TRUE, auto_unbox = TRUE)
write(ListJSON, "quantiles_tilt.json")
