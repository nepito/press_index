Counterpressing <- R6::R6Class("Counterpressing", list(
  raw_data = NULL,
  matches = NULL,
  losses_recovery_rivals = NULL,
  initialize = function(path, team_name) {
  },
  set_raw_data = function(raw_data) {
    self$raw_data <- raw_data
    private$get_matches()
    self$losses_recovery_rivals <- self$raw_data |>
      dplyr::filter(Team != "Eintracht Frankfurt")
  }
),
private = list(
  get_matches = function() {
    self$matches <- self$raw_data$Match |> unique()
  }
)
)
