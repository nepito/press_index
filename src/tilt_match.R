library(tidyverse)
library(wstools)

names <- c("Liverpool", "Chelsea", "Manchester City", "Tottenham Hotspur", "Arsenal", "Brighton")
liverpool <- read_team_stats("/workdir/data/Liverpool.csv") |>
  filter_premier_league()

liverpool <- liverpool |>
  add_tilt() |>
  filter(Team == "Liverpool") |>
  select(1,2,7:8,109:111)

chelsea <- read_team_stats("/workdir/data/Chelsea.csv") |>
  filter_premier_league()

chelsea <- chelsea |>
  add_tilt() |>
  filter(Team == "Chelsea")

city <- read_team_stats("/workdir/data/Manchester_City.csv") |>
  filter_premier_league()

city <- city |>
  add_tilt() |>
  filter(Team == "Manchester City")

arsenal <- read_team_stats("/workdir/data/Arsenal.csv") |>
  filter_premier_league()

arsenal <- arsenal |>
  add_tilt() |>
  filter(Team == "Arsenal")

tottenham <- read_team_stats("/workdir/data/Tottenham_Hotspur.csv") |>
  filter_premier_league()

tottenham <- tottenham |>
  add_tilt() |>
  filter(Team == "Tottenham Hotspur")

brighton <- read_team_stats("/workdir/data/Brighton.csv") |>
  filter_premier_league()

brighton <- brighton |>
  add_tilt() |>
  filter(Team == "Brighton")
