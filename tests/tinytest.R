
if (requireNamespace("tinytest", quietly = TRUE)) {
  Sys.setenv(R_USER_CACHE_DIR  = tempfile("RcppOTIO_cache_"),
             R_USER_DATA_DIR   = tempfile("RcppOTIO_data_"),
             R_USER_CONFIG_DIR = tempfile("RcppOTIO_config_"))
  tinytest::test_package("RcppOTIO")
}

