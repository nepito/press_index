describe("Counterpressing", {
  frankfurt <- readr::read_csv("/workdir/tests/data/Eintracht_Frankfurt.csv", show_col_types = FALSE)
  coun_press <- Counterpressing$new()
  coun_press$set_raw_data(frankfurt)
  it("`set_raw_data()`", {
    expected_n_row <- 12
    obtained_n_row <- nrow(coun_press$raw_data)
    expect_equal(obtained_n_row, expected_n_row)
  })
  it("Property: `matches`", {
    n_matches <- length(coun_press$matches)
    expected_n_matches <- 6
    expect_equal(n_matches, expected_n_matches)
  })
  it("Property: `losses_recovery_rivals`", {
    losses_recovery_rivals <- coun_press$losses_recovery_rivals
    expected_n_matches <- 6
    expect_equal(nrow(losses_recovery_rivals), expected_n_matches)
    expected_n_columns <- 9
    expect_equal(ncol(losses_recovery_rivals), expected_n_columns)
    expected_name <- "losses_rivals"
    obtained_name <- names(losses_recovery_rivals)[2]
    expected_name <- "recoveries_rivals"
    obtained_name <- names(losses_recovery_rivals)[6]
  })
  it("Property: `losses_recovery`", {
    losses_recovery <- coun_press$losses_recovery
    expected_n_matches <- 6
    expect_equal(nrow(losses_recovery), expected_n_matches)
    expected_n_columns <- 10
    expect_equal(ncol(losses_recovery), expected_n_columns)
    expected_name <- "losses"
    obtained_name <- names(losses_recovery)[3]
    expect_equal(obtained_name, expected_name)
    expected_name <- "recoveries"
    obtained_name <- names(losses_recovery)[7]
    expect_equal(obtained_name, expected_name)
  })
  it("Property: `all_losses_recovery`", {
    losses_recovery <- coun_press$all_losses_recovery
    expected_n_matches <- 6
    expect_equal(nrow(losses_recovery), expected_n_matches)
    expected_n_columns <- 19
    expect_equal(ncol(losses_recovery), expected_n_columns)
  })
})

describe("Counterpressing: Bayer Leverkusen", {
  leverkusen <- readr::read_csv("/workdir/tests/data/Bayer_Leverkusen.csv", show_col_types = FALSE)
  coun_press <- Counterpressing$new()
  coun_press$set_raw_data(leverkusen)
  it("Property: `all_losses_recovery`", {
    losses_recovery <- coun_press$all_losses_recovery
    expected_n_matches <- 13
    expect_equal(nrow(losses_recovery), expected_n_matches)
    expected_n_columns <- 19
    expect_equal(ncol(losses_recovery), expected_n_columns)
  })
})
