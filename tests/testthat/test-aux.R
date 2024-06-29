describe("obtain_files_names", {
  it("tests/data", {
    expected <- c("Barcelona", "Liverpool")
    obtained <- obtain_files_names("/workdir/tests/data")
    expect_equal(obtained, expected)
  })
  it("return just the team name", {
    files_name_list <- c("Team Stats Barcelona.xlsx", "Team Stats Liverpool.xlsx")
    expected <- c("Barcelona", "Liverpool")
    obtained <- .clean_files_name(files_name_list)
    expect_equal(obtained, expected)
  })
})
