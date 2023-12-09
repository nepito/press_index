describe("Counterpressing", {
  it("Init", {
    frankfurt <- readr::read_csv("/workdir/tests/data/Eintracht_Frankfurt.csv", show_col_types = FALSE)
    coun_press <- Counterpressing$new()
    coun_press$set_raw_data(frankfurt)
    expected_n_row <- 12
    obtained_n_row <- nrow(coun_press$raw_data)
    expect_equal(obtained_n_row, expected_n_row)
  })
})
