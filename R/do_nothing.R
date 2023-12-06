normalize_delta <- function(raw_data) {
  return(.normalize_index(raw_data, "delta"))
}

normalize_ppda <- function(raw_data) {
  return(.normalize_index(raw_data, "ppda"))
}

normalize_bdp <- function(raw_data) {
  return(.normalize_index(raw_data, "build_up_disruption"))
}

normalize_offe_tran <- function(raw_data) {
  return(.normalize_index(raw_data, "offe_tran"))
}

calculate_offensive_transition <- function(raw_data) {
  raw_data |> dplyr::mutate(offe_tran = tempo * xG / delta_n)
}

calculate_high_pression <- function(raw_data) {
  raw_data |> dplyr::mutate(high_pression = build_up_disruption_n / ppda_n)
}

.normalize_index <- function(raw_data, col_name) {
  min_d <- min(raw_data[[col_name]], na.rm = TRUE)
  max_d <- max(raw_data[[col_name]], na.rm = TRUE)
  diff_d <- max_d - min_d
  new_name <- glue::glue("{col_name}_n")
  raw_data[[new_name]] <- 1 + (raw_data[[col_name]] - min_d) / diff_d
  return(raw_data)
}
