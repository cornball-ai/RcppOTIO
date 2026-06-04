#' rotio: R Bindings for OpenTimelineIO
#'
#' An Rcpp wrapper over the OpenTimelineIO (OTIO) C++ library. The OTIO
#' time value types (\code{RationalTime}, \code{TimeRange},
#' \code{TimeTransform}) are represented as plain classed R values, while
#' the serializable schema objects (\code{Timeline}, \code{Stack},
#' \code{Track}, \code{Clip}, and the rest) are held behind external
#' pointers with OTIO's intrusive reference counting.
#'
#' Names follow OTIO exactly: \code{source_range}, \code{range_in_parent},
#' \code{append_child}, and so on. Tree children are addressed by position
#' and object reference, never by name.
#'
#' @useDynLib rotio, .registration = TRUE
#' @importFrom Rcpp evalCpp
#' @name rotio-package
#' @keywords internal
"_PACKAGE"
