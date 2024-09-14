add_wheel_index <- function(league_data, left_align = FALSE) {
  how_align <- .obtain_how_align(left_align)
  league_data_with_wheel_index <- league_data |>
    dplyr::mutate(
      central_p = passes * 100 / crosses,
      circulation = passes / progressive_passes,
      patient_attack = shots * 100 / passes_to_final_third,
      shot_quality = x_g / shots,
      creation = x_g * 90 / duration,
      deep_build_up = passes / long_passes,
      press_resistance = (passes - passes_to_final_third) / (losses_low + losses_medium),
      ppda_mean = .roll_mean(ppda, how_align),
      tempo_mean = .roll_mean(match_tempo, how_align),
      deep_build_up_mean = .roll_mean(deep_build_up, how_align),
      press_resistance_mean = .roll_mean(press_resistance, how_align),
      possession_mean = .roll_mean(possession_percent, how_align),
      central_p_mean = .roll_mean(central_p, how_align),
      circulation_mean = .roll_mean(circulation, how_align),
      patient_attack_mean = .roll_mean(patient_attack, how_align),
      creation_mean = .roll_mean(creation, how_align),
      shot_quality_mean = .roll_mean(shot_quality, how_align)
    )
  return(league_data_with_wheel_index)
}

.roll_mean <- function(variable, how_align) {
  return(zoo::rollapply({{ variable }}, width = 4, mean, fill = NA, align = how_align))
}

.obtain_how_align <- function(left_align) {
  how_align <- "right"
  if (left_align) {
    how_align <- "left"
  }
  return(how_align)
}

select_wheel_index <- function(league_data_with_wheel_index) {
  league_data_with_wheel_index |>
    dplyr::select(
      1:3,
      ppda_mean,
      tempo_mean,
      central_p_mean,
      circulation_mean,
      possession_mean,
      shot_quality_mean,
      patient_attack_mean,
      creation_mean,
      press_resistance_mean,
      deep_build_up_mean,
      passes_to_final_third
    )
}

filter_rivals_data_of_team <- function(data, team_name) {
  filtered_data <- data |>
    dplyr::filter(stringr::str_detect(match, team_name), team != team_name)
}

add_wheel_index_from_rivals <- function(rivals_league_data, left_align = FALSE) {
  how_align <- "right"
  league_data_with_wheel_index <- rivals_league_data |>
    dplyr::mutate(
      rivals_passes_to_final_third = passes_to_final_third,
      high_line = counterattacks + offsides,
      chance_prevention_mean = .roll_mean(x_g, how_align),
      high_line_mean = .roll_mean(high_line, how_align)
    )
  return(league_data_with_wheel_index)
}

rivals_select_wheel_index <- function(rivals_league_data_with_wheel_index) {
  rivals_league_data_with_wheel_index |>
    dplyr::select(
      1:3, rivals_passes_to_final_third, high_line_mean, chance_prevention_mean
    )
}
