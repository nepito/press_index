#' @export
calculate_ggpi <- function(raw_data) {
  data_with_ggpri <- raw_data |>
    normalize_delta() |>
    normalize_ppda() |>
    normalize_bdp() |>
    calculate_offensive_transition() |>
    normalize_offe_tran() |>
    calculate_high_pression() |>
    dplyr::mutate(ggpi = high_pression * offe_tran_n)
}