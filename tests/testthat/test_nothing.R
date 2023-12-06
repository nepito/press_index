describe("Get version of the module", {
  it("The version is 0.1.0", {
    expected_version <- c("0.1.0")
    obtained_version <- packageVersion("pression")
    version_are_equal <- expected_version == obtained_version
    expect_true(version_are_equal)
  })
})

describe("Normalize variable", {
  it("delta", {
    raw <- tibble::tibble(delta = c(1, 2, 3, 4, 5))
    expected <- tibble::tibble(delta = c(1, 2, 3, 4, 5), delta_n = c(1, 1.25, 1.5, 1.75, 2))
    obtained <- normalize_delta(raw)
    expect_equal(expected, obtained)
  })
  it("ppda", {
    raw <- tibble::tibble(ppda = c(1, 2, 3, 4, 5))
    expected <- tibble::tibble(ppda = c(1, 2, 3, 4, 5), ppda_n = c(1, 1.25, 1.5, 1.75, 2))
    obtained <- normalize_ppda(raw)
    expect_equal(expected, obtained)
  })
  it("offe_tran", {
    raw <- tibble::tibble(offe_tran = c(1, 2, 3, 4, 5))
    expected <- tibble::tibble(
      offe_tran = c(1, 2, 3, 4, 5),
      offe_tran_n = c(1, 1.25, 1.5, 1.75, 2)
    )
    obtained <- normalize_offe_tran(raw)
    expect_equal(expected, obtained)
  })
  it("build_up_disruption", {
    raw <- tibble::tibble(build_up_disruption = c(1, 2, 3, 4, 5))
    expected <- tibble::tibble(
      build_up_disruption = c(1, 2, 3, 4, 5),
      build_up_disruption_n = c(1, 1.25, 1.5, 1.75, 2)
    )
    obtained <- normalize_bdp(raw)
    expect_equal(expected, obtained)
  })
  it("Offensive transition", {
    raw <- tibble::tibble(
      tempo = c(1, 2, 3, 4, 5),
      xG = c(2, 3, 4, 5, 6),
      delta_n = c(1, 1.25, 1.5, 1.75, 2)
    )
    expected <- tibble::tibble(
      tempo = c(1, 2, 3, 4, 5),
      xG = c(2, 3, 4, 5, 6),
      delta_n = c(1, 1.25, 1.5, 1.75, 2),
      offe_tran = c(2, 4.8, 8, 11.42857, 15)
    )
    obtained <- calculate_offensive_transition(raw)
    expect_equal(expected, obtained, tolerance = 1e-3)
  })
})
