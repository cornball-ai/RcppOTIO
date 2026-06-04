# OpenTime value types. RationalTime / TimeRange / TimeTransform are
# immutable values, represented as plain classed R objects and converted
# to/from C++ only at the call boundary. std::optional maps to NULL.

# ---- RationalTime ----------------------------------------------------

#' RationalTime
#'
#' A time expressed as a value at a sample rate (e.g. a frame number at a
#' frame rate). Stored as a classed numeric vector with elements
#' \code{value} and \code{rate}.
#'
#' @param value Numeric sample value (e.g. frame count).
#' @param rate Numeric sample rate (e.g. frames per second).
#' @return A \code{RationalTime} object.
#' @export
RationalTime <- function(value = 0, rate = 1) {
    structure(c(value = as.numeric(value), rate = as.numeric(rate)),
              class = "RationalTime")
}

#' @export
print.RationalTime <- function(x, ...) {
    cat(sprintf("RationalTime(value = %g, rate = %g)\n", x[["value"]], x[["rate"]]))
    invisible(x)
}

#' Value and rate accessors
#'
#' @param x A \code{RationalTime}, \code{TimeTransform}, or other OTIO
#'   object carrying a \code{value} or \code{rate} field.
#' @return A numeric scalar.
#' @export
value <- function(x) UseMethod("value")

#' @export
value.RationalTime <- function(x) unname(x[["value"]])

#' @rdname value
#' @export
rate <- function(x) UseMethod("rate")

#' @export
rate.RationalTime <- function(x) unname(x[["rate"]])

#' @export
rate.TimeTransform <- function(x) x[["rate"]]

#' Convert a RationalTime to seconds
#' @param rt A \code{RationalTime}.
#' @return Numeric seconds.
#' @export
to_seconds <- function(rt) cpp_rt_to_seconds(rt)

#' Build a RationalTime from seconds
#' @param seconds Numeric seconds.
#' @param rate Target sample rate.
#' @return A \code{RationalTime}.
#' @export
from_seconds <- function(seconds, rate = 1) cpp_rt_from_seconds(seconds, rate)

#' Convert a RationalTime to a frame number
#' @param rt A \code{RationalTime}.
#' @return Integer frame number at the time's own rate.
#' @export
to_frames <- function(rt) cpp_rt_to_frames(rt)

#' Build a RationalTime from a frame number
#' @param frame Frame number.
#' @param rate Frame rate.
#' @return A \code{RationalTime}.
#' @export
from_frames <- function(frame, rate) cpp_rt_from_frames(frame, rate)

#' Rescale a RationalTime to a new rate
#' @param rt A \code{RationalTime}.
#' @param new_rate Target rate.
#' @return A \code{RationalTime} at \code{new_rate}.
#' @export
rescaled_to <- function(rt, new_rate) cpp_rt_rescaled_to(rt, new_rate)

#' SMPTE timecode conversions
#'
#' @param rt A \code{RationalTime}.
#' @param rate Timecode rate.
#' @param drop_frame -1 infer, 0 force non-drop, 1 force drop-frame.
#' @return A timecode string.
#' @export
to_timecode <- function(rt, rate, drop_frame = -1L) {
    cpp_rt_to_timecode(rt, rate, as.integer(drop_frame))
}

#' @rdname to_timecode
#' @param timecode A SMPTE timecode string.
#' @export
from_timecode <- function(timecode, rate) cpp_rt_from_timecode(timecode, rate)

#' Time-string conversions (HH:MM:SS.s)
#' @param rt A \code{RationalTime}.
#' @return A time string.
#' @export
to_time_string <- function(rt) cpp_rt_to_time_string(rt)

#' @rdname to_time_string
#' @param time_string A \code{HH:MM:SS.s} string.
#' @param rate Sample rate.
#' @export
from_time_string <- function(time_string, rate) cpp_rt_from_time_string(time_string, rate)

#' Approximate RationalTime equality
#' @param a,b \code{RationalTime} objects.
#' @param delta Tolerance in value units after rescaling.
#' @return Logical.
#' @export
almost_equal <- function(a, b, delta = 0) cpp_rt_almost_equal(a, b, delta)

#' @export
Ops.RationalTime <- function(e1, e2) {
    if (.Generic %in% c("+", "-")) {
        if (.Generic == "+") return(cpp_rt_add(e1, e2))
        return(cpp_rt_subtract(e1, e2))
    }
    cmp <- cpp_rt_compare(e1, e2)
    switch(.Generic,
           "==" = cmp == 0L,
           "!=" = cmp != 0L,
           "<"  = cmp < 0L,
           ">"  = cmp > 0L,
           "<=" = cmp <= 0L,
           ">=" = cmp >= 0L,
           stop(sprintf("operator '%s' not defined for RationalTime", .Generic)))
}

# ---- TimeRange -------------------------------------------------------

#' TimeRange
#'
#' A span with a start time and a duration. Stored as a classed list with
#' elements \code{start_time} and \code{duration}, each a
#' \code{RationalTime}.
#'
#' @param start_time A \code{RationalTime}.
#' @param duration A \code{RationalTime}.
#' @return A \code{TimeRange}.
#' @export
TimeRange <- function(start_time = RationalTime(), duration = RationalTime()) {
    structure(list(start_time = start_time, duration = duration),
              class = "TimeRange")
}

#' @export
print.TimeRange <- function(x, ...) {
    cat("TimeRange\n")
    cat("  start_time: "); print(x$start_time)
    cat("  duration:   "); print(x$duration)
    invisible(x)
}

#' TimeRange start and duration accessors
#' @param tr A \code{TimeRange}.
#' @return A \code{RationalTime}.
#' @export
start_time <- function(tr) tr$start_time

#' Exclusive and inclusive end times of a TimeRange
#' @param tr A \code{TimeRange}.
#' @return A \code{RationalTime}.
#' @export
end_time_exclusive <- function(tr) cpp_tr_end_time_exclusive(tr)

#' @rdname end_time_exclusive
#' @export
end_time_inclusive <- function(tr) cpp_tr_end_time_inclusive(tr)

#' Extend a TimeRange to cover another
#' @param tr,other \code{TimeRange} objects.
#' @return A \code{TimeRange}.
#' @export
extended_by <- function(tr, other) cpp_tr_extended_by(tr, other)

#' Clamp one TimeRange to another
#' @param tr,other \code{TimeRange} objects.
#' @return A \code{TimeRange}.
#' @export
clamped <- function(tr, other) cpp_tr_clamped_range(tr, other)

#' Does a TimeRange contain a time or range?
#'
#' For a \code{RationalTime}, containment is half-open: the start is
#' included, the exclusive end is not. For a \code{TimeRange}, OTIO is
#' strict at both edges, so a range sharing a boundary with \code{tr} is
#' not contained; only strictly-interior ranges are.
#'
#' @param tr A \code{TimeRange}.
#' @param other A \code{RationalTime} or \code{TimeRange}.
#' @param epsilon_s Tolerance in seconds (range comparison only).
#' @return Logical.
#' @export
contains <- function(tr, other, epsilon_s = 1 / 384000) {
    if (inherits(other, "TimeRange")) cpp_tr_contains_range(tr, other, epsilon_s)
    else cpp_tr_contains_time(tr, other)
}

#' Does a TimeRange overlap another range?
#' @param tr,other \code{TimeRange} objects.
#' @param epsilon_s Tolerance in seconds.
#' @return Logical.
#' @export
overlaps <- function(tr, other, epsilon_s = 1 / 384000) {
    cpp_tr_overlaps_range(tr, other, epsilon_s)
}

#' Do two TimeRanges intersect?
#' @param tr,other \code{TimeRange} objects.
#' @param epsilon_s Tolerance in seconds.
#' @return Logical.
#' @export
intersects <- function(tr, other, epsilon_s = 1 / 384000) {
    cpp_tr_intersects(tr, other, epsilon_s)
}

#' Build a TimeRange from start and exclusive end times
#' @param start_time,end_time_exclusive \code{RationalTime} objects.
#' @return A \code{TimeRange}.
#' @export
range_from_start_end_time <- function(start_time, end_time_exclusive) {
    cpp_tr_range_from_start_end_time(start_time, end_time_exclusive)
}

# ---- TimeTransform ---------------------------------------------------

#' TimeTransform
#'
#' An offset/scale/rate transform applied to times. Stored as a classed
#' list with elements \code{offset} (a \code{RationalTime}), \code{scale},
#' and \code{rate}.
#'
#' @param offset A \code{RationalTime}.
#' @param scale Numeric scale factor.
#' @param rate Numeric rate (-1 leaves the rate unchanged).
#' @return A \code{TimeTransform}.
#' @export
TimeTransform <- function(offset = RationalTime(), scale = 1, rate = -1) {
    structure(list(offset = offset, scale = as.numeric(scale), rate = as.numeric(rate)),
              class = "TimeTransform")
}

#' @export
print.TimeTransform <- function(x, ...) {
    cat(sprintf("TimeTransform(scale = %g, rate = %g)\n", x$scale, x$rate))
    cat("  offset: "); print(x$offset)
    invisible(x)
}
