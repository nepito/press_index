Counterpressing <- R6::R6Class("Counterpressing", list(
  raw_data = NULL,
  matches = NULL,
  initialize = function(path, team_name) {
  },
  set_raw_data = function(raw_data) {
    self$raw_data <- raw_data
    private$get_matches()
  }),
  private = list(
    get_matches = function() {
      self$matches <- self$raw_data$Match |> unique()
    }
  )
)
