Counterpressing <- R6::R6Class("Counterpressing", list(
  raw_data = NULL,
  matches = NULL,
  losses_recovery_rivals = NULL,
  losses_recovery = NULL,
  all_losses_recovery = NULL,
  team_name = NULL,
  initialize = function(team_name) {
	  self$team_name <- team_name
  },
  set_raw_data = function(raw_data) {
    self$raw_data <- raw_data
    private$get_matches()
    private$set_losses_recovery_rivals()
    private$set_losses_recovery()
    private$set_all_losses_recovery()
  }
),
private = list(
  col_name_rivals = c("Match", "losses_rivals", "low_losses_rivals", "medium_losses_rivals", "high_losses_rivals", "recoveries_rivals", "low_recoveries_rivals", "medium_recoveries_rivals", "high_recoveries_rivals"),
  col_name = c("Date", "Match", "losses", "low_losses", "medium_losses", "high_losses", "recoveries", "low_recoveries", "medium_recoveries", "high_recoveries"),
  get_matches = function() {
    self$matches <- self$raw_data$Match |> unique()
  },
  set_losses_recovery_rivals = function() {
    init_losses <- private$get_init_losses()
    self$losses_recovery_rivals <- self$raw_data |>
      dplyr::filter(Team != self$team_name) |>
      dplyr::select(c(2, seq(init_losses, init_losses + 7)))
    names(self$losses_recovery_rivals) <- private$col_name_rivals
  },
  set_losses_recovery = function() {
    init_losses <- private$get_init_losses()
    self$losses_recovery <- self$raw_data |>
      dplyr::filter(Team == self$team_name) |>
      dplyr::select(c(1, 2, seq(init_losses, init_losses + 7)))
    names(self$losses_recovery) <- private$col_name
  },
  set_all_losses_recovery = function() {
    self$all_losses_recovery <- self$losses_recovery |>
      dplyr::left_join(self$losses_recovery_rivals, by = c("Match" = "Match")) |>
      dplyr::mutate(counterpress = 100 * high_recoveries/low_recoveries_rivals)
  },
  get_init_losses = function() {
    return(16)
  }
)
)
