describe("obtain_files_names", {
  it("tests/data", {
    expected <- c("Barcelona", "Liverpool")
    obtained <- obtain_files_names("tests/data")
    expect_equal(obtained, expected)
  })
})
