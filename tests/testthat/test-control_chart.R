library(jsonlite)
describe("add_wheel_index()", {
  dp <- fromJSON("/workdir/tests/data/datapackage.json")
  names_from_dp <- dp$resources$schema$fields[[1]]$name
  data <- readr::read_csv("/workdir/tests/data/tijuana.csv", show_col_types = FALSE, col_names = names_from_dp, skip = 1) |>
    janitor::clean_names()
  data_with_wheel <- data |> add_wheel_index()
  n_rows <- nrow(data_with_wheel)
  last_index <- seq(n_rows, n_rows - 3, -1)
  it("possession_mean", {
    obtained <- data_with_wheel |>
      dplyr::pull(possession_mean)
    expected <- c(50, 46.44, 50, 50.255)
    expect_equal(obtained[last_index], expected)
  })
  it("ppda_mean", {
    obtained <- data_with_wheel |>
      dplyr::pull(ppda_mean)
    n_rows <- length(obtained)
    expected <- c(12.4, 12.4, 9.8, 9.4)
    expect_equal(obtained[last_index], expected, tolerance = 1e-2)
  })
  it("central_p_mean", {
    obtained <- data_with_wheel |>
      dplyr::pull(central_p_mean)
    n_rows <- length(obtained)
    expected <- c(4756, 2434, 2374, 2245)
    expect_equal(obtained[last_index], expected, tolerance = 1e-2)
  })
  it("central_p_mean: left", {
    obtained <- data |>
      add_wheel_index(left_align = TRUE) |>
      dplyr::pull(central_p_mean)
    n_rows <- length(obtained)
    expected <- c(2943, 2947, 2772, 3572)
    expect_equal(obtained[1:4], expected, tolerance = 1e-2)
  })
  it("shot_quality_mean", {
    obtained <- data_with_wheel |>
      dplyr::pull(shot_quality_mean)
    n_rows <- length(obtained)
    expected <- c(0.0895, 0.0821, 0.0824, 0.0993)
    expect_equal(obtained[last_index], expected, tolerance = 1e-2)
  })
  it("patient_attack_mean", {
    obtained <- data_with_wheel |>
      dplyr::pull(patient_attack_mean)
    n_rows <- length(obtained)
    expected <- c(26, 30, 30, 25)
    expect_equal(obtained[last_index], expected, tolerance = 1e-2)
  })
  it("creation_mean", {
    obtained <- data_with_wheel |>
      dplyr::pull(creation_mean)
    expected <- c(0.81, 0.97, 1.07, 1.16)
    expect_equal(obtained[last_index], expected, tolerance = 1e-2)
  })
  it("circulation_mean", {
    obtained <- data_with_wheel |>
      dplyr::pull(circulation_mean)
    expected <- c(6.6, 5.6, 5.4, 5.3)
    expect_equal(obtained[last_index], expected, tolerance = 1e-2)
  })
})

describe("add_wheel_index_from_rivals()", {
  dp <- fromJSON("/workdir/tests/data/datapackage.json")
  names_from_dp <- dp$resources$schema$fields[[1]]$name
  data <- readr::read_csv("/workdir/tests/data/tijuana.csv", show_col_types = FALSE, col_names = names_from_dp, skip = 1) |>
    janitor::clean_names()
  rivals_data <- data |>
    filter_rivals_data_of_team("Club Tijuana") |>
    add_wheel_index_from_rivals()
  n_rows <- nrow(rivals_data)
  last_index <- seq(n_rows, n_rows - 3, -1)
  it("filter_rivals_data_of_team()", {
    expected <- 35
    expect_equal(n_rows, expected)
  })
  it("chance_prevention_mean", {
    obtained <- rivals_data |>
      dplyr::pull(chance_prevention_mean)
    expected <- c(1.4, 2.1, 2.2, 2.2)
    expect_equal(obtained[last_index], expected, tolerance = 1e-2)
  })
  it("high_line_mean", {
    obtained <- rivals_data |>
      dplyr::pull(high_line_mean)
    expected <- c(3.4, 3.1, 3.2, 3.2)
    expect_equal(obtained[last_index], expected, tolerance = 1e-2)
  })
})
