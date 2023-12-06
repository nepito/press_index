#' @export
calculate_ggpi <- function(raw_data) {
  data_with_ggpri <- raw_data |>
    normalize_delta() |>
    normalize_ppda() |>
    normalize_bdp() |>
    calculate_offensive_transition() |>
    normalize_offe_tran() |>
    dplyr::mutate(ggpi = (build_up_disruption_n * offe_tran_n) / ppda_n)
}