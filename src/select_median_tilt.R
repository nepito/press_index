library("tidyverse")
library("comprehenr")
library("jsonlite")
library("wstools")

league <- "263"
path_tilt <- glue::glue("quantiles_tilt_{league}.json")
all_team_tilts <- fromJSON(path_tilt)
name_teams <- names(all_team_tilts)


all_team_stats[["Celaya"]] |>
  filter(Team == "Celaya") |>
  mutate(rivales = 100 - tilt) |>
  write_csv("celaya_liga_mx.csv")

tilt <- to_vec(for (team in name_teams) all_team_tilts[[team]][3])
path_median_tilt <- glue::glue("median_tilt_{league}.csv")
tibble::tibble(team = name_teams, tilt = tilt) |>
  arrange(-tilt) |>
  write_csv(path_median_tilt)


# america <- read_team_stats("data/América.csv") |>
#   filter(Team == "América") |>
#   write_csv("america_liga_mx.csv")
