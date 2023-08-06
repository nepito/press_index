library(tidyverse)
library("comprehenr")
library(jsonlite)

league <- "135"
tilts <- fromJSON(glue::glue("quantiles_tilt_{league}.json"))
ppda <- read_csv(glue::glue("build_up_and_ppda_{league}.csv"), show_col_types = FALSE)
teams <- ppda$team
tilt <- to_vec(for (team in teams) tilts[[team]][3])
ppda$tilt <- tilt
ppda |> write_csv(glue::glue("xG_build-up_ppda_tilt_{league}.csv"))