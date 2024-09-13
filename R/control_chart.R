add_wheel_index <- function(league_data, left_align = FALSE) {
  how_align <- "right"
  if (left_align) {
    how_align <- "left"
  }
  league_data_with_wheel_index <- league_data |>
    dplyr::mutate(
      central_p = passes_accurate * 100 / crosses_accurate,
      ppda_mean = zoo::rollapply(ppda, width = 4, mean, fill = NA, align = how_align),
      tempo_mean = zoo::rollapply(match_tempo, width = 4, mean, fill = NA, align = how_align),
      possession_mean = zoo::rollapply(possession_percent, width = 4, mean, fill = NA, align = how_align),
      central_p_mean = zoo::rollapply(central_p, width = 4, mean, fill = NA, align = how_align)
    )
  return(league_data_with_wheel_index)
}

select_wheel_index <- function(league_data_with_wheel_index) {
  league_data_with_wheel_index |>
    dplyr::select(1:3, ppda_mean, tempo_mean, central_p_mean, possession_mean)
}
