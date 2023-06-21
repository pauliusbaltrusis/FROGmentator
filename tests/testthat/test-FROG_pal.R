test_that("FROG_pal returns a vector of length", {
  expect_equal(FROG_pal('GGGGGACGGGGG', 'AC'), c(5,6))
})
