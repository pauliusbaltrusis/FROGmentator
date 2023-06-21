test_that("Strings gen works", {
  expect_equal(gen_DNA(10), DNAString(start=1,x='AAAAAAAAAA'))
})
