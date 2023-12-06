return_one <- function() {
  return(1)
}

normalize_delta <- function(raw_data) {
  min_d <- min(raw_data$delta, na.rm = TRUE)
  max_d <- max(raw_data$delta, na.rm = TRUE)
  diff_d <- max_d - min_d
  return(raw_data |> dplyr::mutate(delta_n = 1 + (delta - min_d) / diff_d))
}
