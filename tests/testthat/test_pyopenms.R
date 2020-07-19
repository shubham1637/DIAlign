context("Merge two chromatograms")
envName <- "TricEnvr"

# helper function to skip tests if we don't have the 'foo' module
skip_if_no_pyopenms <- function() {
  ropenms <- try(get_ropenms(condaEnv = envName, useConda=TRUE))
  no_ropenms <- is(ropenms, "try-error")
  if(no_ropenms)
    skip("ropenms not available for testing.")
}

test_that("test_get_ropenms",{
  skip_if_no_pyopenms()
})

test_that("test_addXIC",{
  skip_if_no_pyopenms()
  ropenms = get_ropenms(condaEnv = envName, useConda=TRUE)
  expriment = ropenms$MSExperiment()
  data(XIC_QFNNTDIVLLEDFQK_3_DIAlignR)
  xic <- XIC_QFNNTDIVLLEDFQK_3_DIAlignR[["run0"]][["14299_QFNNTDIVLLEDFQK/3"]][[1]]
  addXIC(ropenms, expriment, xic, 34L)
  chroms <- expriment$getChromatograms()

  x1 <- reticulate::py_to_r(chroms[[0]]$getNativeID())
  x2 <- reticulate::py_to_r(chroms[[0]]$get_peaks())

  expect_identical(as.character(x1), "34")
  expect_identical(length(x2), 2L)
  expect_equal(x2[[1]], as.array(xic[[1]]))
  expect_equal(x2[[2]], as.array(xic[[2]]))
})

test_that("test_createMZML",{
  skip_if_no_pyopenms()
  ropenms <- get_ropenms(condaEnv = envName, useConda=TRUE)
  expriment <- ropenms$MSExperiment()
  data(XIC_QFNNTDIVLLEDFQK_3_DIAlignR)
  XICs <- XIC_QFNNTDIVLLEDFQK_3_DIAlignR[["run0"]]
  transitionIDs <- list(c(35L, 36L, 37L, 38L, 39L, 410L))
  filename <- "temp.chrom.mzML"
  DIAlignR:::createMZML(ropenms, filename, XICs, transitionIDs)
  outData <- mzR::chromatograms(mzR::openMSfile(filename, backend = "pwiz"))
  expect_identical(sapply(outData, colnames)[2,], c("X35","X36","X37","X38","X39","X410"))
  for (i in seq_along(outData)){
    expect_equal(outData[[i]][[1]], XICs[[1]][[i]][[1]]) # Time
    expect_equal(outData[[i]][[2]], XICs[[1]][[i]][[2]]) # Intensity
  }
  file.remove(filename)
})