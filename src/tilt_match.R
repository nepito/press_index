library(tidyverse)
library(wstools)

liverpool <- read_team_stats("/workdir/data/Liverpool.csv") |>
  filter_premier_league()

liverpool <- liverpool |>
  add_tilt()
liverpool |>
  filter(Team == "Liverpool") |>
  select(1,2,7:8,109:111)

