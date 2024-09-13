add_wheel_index <- function(league_data, left_align = FALSE) {
  how_align <- .obtain_how_align(left_align)
  league_data_with_wheel_index <- league_data |>
    dplyr::mutate(
      central_p = passes_accurate * 100 / crosses_accurate,
      shot_quality = shots_on_target * 100 / passes_to_final_third_accurate,
      ppda_mean = .roll_mean(ppda, how_align),
      tempo_mean = .roll_mean(match_tempo, how_align),
      possession_mean = .roll_mean(possession_percent, how_align),
      central_p_mean = .roll_mean(central_p, how_align),
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
    dplyr::select(1:3, ppda_mean, tempo_mean, central_p_mean, possession_mean)
}
