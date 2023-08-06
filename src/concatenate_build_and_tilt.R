library(tidyverse)
library("comprehenr")
library(jsonlite)

league <- "135"
tilts <- fromJSON("quantiles_tilt_135.json")
ppda <- read_csv("build_up_and_ppda_135.csv", show_col_types = FALSE)
teams <- ppda$team
tilt <- to_vec(for (team in teams) tilts[[team]][3])
ppda$tilt <- tilt
ppda |> write_csv("xG_build-up_ppda_tilt_135.csv")