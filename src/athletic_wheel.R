athletic <- data |>
  mutate(
    deep_bu = Passes/`Long passes_accurate`,
    patient = Shots*100/`Passes to final third`,
    central_p = Passes*100/Crosses,
    shot_q = xG/Shots,
    creation = xG*90/Duration,
    circulation = Passes/`Progressive passes`
  ) |>
  group_by(Team) |>
  summarize(
    deep_build_up = mean(deep_bu),
    possesion = mean(`Possession, %`),
    central_progession = mean(central_p),
    circulation = mean(circulation),
    intensity = mean(1/PPDA),
    patient = mean(patient),
    creation = mean(creation),
    shot_quality = mean(shot_q)
  )