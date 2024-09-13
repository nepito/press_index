describe("add_wheel_index()", {
  data <- readr::read_csv("/workdir/tests/data/tijuana.csv", show_col_types = FALSE)
  it("possession_mean", {
    obtained <- data |> add_wheel_index() |> dplyr::pull(possession_mean)
    n_rows <- length(obtained)
    expected <- c(50, 46.44, 50, 50.255)
    expect_equal(obtained[seq(n_rows,n_rows-3, -1)], expected)
  })
  it("ppda_mean", {
    obtained <- data |> add_wheel_index() |> dplyr::pull(ppda_mean)
    n_rows <- length(obtained)
    expected <- c(12.4, 12.4, 9.8, 9.4)
    expect_equal(obtained[seq(n_rows,n_rows-3, -1)], expected, tolerance=1e-2)
  })
  it("central_p_mean", {
    obtained <- data |> add_wheel_index() |> dplyr::pull(central_p_mean)
    n_rows <- length(obtained)
    expected <- c(4756, 2434, 2374, 2245)
    expect_equal(obtained[seq(n_rows,n_rows-3, -1)], expected, tolerance=1e-2)
  })
  it("central_p_mean: left", {
    obtained <- data |> add_wheel_index(left_align = TRUE) |> dplyr::pull(central_p_mean)
    n_rows <- length(obtained)
    expected <- c(2943, 2947, 2772, 3572)
    expect_equal(obtained[1:4], expected, tolerance=1e-2)
  })
})