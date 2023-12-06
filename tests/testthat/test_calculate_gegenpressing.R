describe("Calculate Gegenpressing", {
  it("ggpi", {
    raw <- tibble::tibble(
      delta = c(1, 2, 3, 4, 5),
      tempo = c(1, 2, 3, 4, 5),
      xG = c(1, 2, 3, 4, 5),
      build_up_disruption = c(1, 2, 3, 4, 5),
      ppda = c(1, 2, 3, 4, 5)
    )
    expected <- c(1, 1.191, 1.435, 1.708, 2.000)
    obtained <- calculate_ggpi(raw)
    expect_equal(expected, obtained$ggpi, tolerance = 1e-3)
  })
})
