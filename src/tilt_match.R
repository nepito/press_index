library(tidyverse)
library(wstools)

liverpool <- read_team_stats("/workdir/data/Liverpool.csv")
pases_totales <- liverpool |>
  filter(grepl("Premier", Competition)) |>
  group_by(Date) |>
  summarize(total_pases = sum(Passes_to_final_third_accurate))

liverpool <- liverpool |>
  left_join(pases_totales, by = "Date") |>
  mutate(tilt = 100*Passes_to_final_third_accurate / total_pases)