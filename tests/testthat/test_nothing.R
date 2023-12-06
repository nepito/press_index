describe("Test all is ready", {
  it("Return one", {
    expected <- 1
    obtained <- return_one()
    expect_equal(expected, obtained)
  })
})

describe("Get version of the module", {
  it("The version is 0.1.0", {
    expected_version <- c("0.1.0")
    obtained_version <- packageVersion("templater")
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
})
