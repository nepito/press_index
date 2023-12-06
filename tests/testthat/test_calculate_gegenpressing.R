describe("Calculate Gegenpressing", {
  it("delta", {
    raw <- tibble::tibble(
      delta = c(1, 2, 3, 4, 5),
      tempo = c(1, 2, 3, 4, 5),
      xG = c(1, 2, 3, 4, 5),
      build_up_disruption = c(1, 2, 3, 4, 5),
      ppda = c(1, 2, 3, 4, 5)
    )
    expected <- c(1, 1.2, 1.3, 1.4, 1.5)
    obtained <- calculate_ggpi(raw)
    expect_equal(expected, obtained$ggpi)
  })
})
