library(tidyverse)
library("comprehenr")
library(jsonlite)

league <- "135_2024"
tilts <- fromJSON(glue::glue("quantiles_tilt_{league}.json"))
deltas <- fromJSON(glue::glue("quantiles_delta_{league}.json"))
tempos <- fromJSON(glue::glue("quantiles_tempo_{league}.json"))
ppda <- read_csv(glue::glue("build_up_and_ppda_{league}.csv"), show_col_types = FALSE)
teams <- ppda$team
tilt <- to_vec(for (team in teams) tilts[[team]][3])
delta <- to_vec(for (team in teams) deltas[[team]][1])
tempo <- to_vec(for (team in teams) tempos[[team]][1])
ppda$tilt <- tilt
ppda$delta <- delta
ppda$tempo <- tempo
ppda |> write_csv(glue::glue("xG_build-up_ppda_tilt_{league}_2023-24.csv"))
