# Composable / Item accessors. Some names (duration, available_range,
# enabled) exist on more than one OTIO type; those dispatch on class.

#' Source range of an Item
#'
#' The stored trim of an item, as a \code{TimeRange}, or \code{NULL} if
#' unset. This is the item's own extent, not its position in a parent
#' (use \code{range_in_parent}).
#'
#' @param x An \code{Item} (Clip, Gap, Track, Stack).
#' @param value A \code{TimeRange} or \code{NULL}.
#' @return A \code{TimeRange} or \code{NULL}; the setter returns \code{x}.
#' @export
source_range <- function(x) cpp_source_range(x)

#' @rdname source_range
#' @export
`source_range<-` <- function(x, value) {
    cpp_set_source_range(x, value)
    x
}

#' Whether an Item or Effect is enabled
#' @param x An \code{Item} or \code{Effect}.
#' @param value Logical.
#' @return Logical; the setter returns \code{x}.
#' @export
enabled <- function(x) {
    if (inherits(x, "Effect")) cpp_effect_enabled(x) else cpp_enabled(x)
}

#' @rdname enabled
#' @export
`enabled<-` <- function(x, value) {
    if (inherits(x, "Effect")) cpp_effect_set_enabled(x, value) else cpp_set_enabled(x, value)
    x
}

#' Duration of an object
#'
#' For a \code{TimeRange} this is its \code{duration} field; for a
#' \code{Timeline} the duration of its tracks; for a \code{Composable}
#' (Item, Clip, Track, ...) the computed duration.
#'
#' @param x A \code{TimeRange}, \code{Timeline}, or \code{Composable}.
#' @return A \code{RationalTime}.
#' @export
duration <- function(x) {
    if (inherits(x, "TimeRange")) return(x$duration)
    if (inherits(x, "Timeline")) return(cpp_timeline_duration(x))
    cpp_duration(x)
}

#' Available range
#'
#' For an \code{Item} the range available to be trimmed; for a
#' \code{MediaReference} the range of the underlying media.
#'
#' @param x An \code{Item} or \code{MediaReference}.
#' @param value A \code{TimeRange} or \code{NULL} (MediaReference only).
#' @return A \code{TimeRange} (or \code{NULL} for an unset media range);
#'   the setter returns \code{x}.
#' @export
available_range <- function(x) {
    if (inherits(x, "MediaReference")) cpp_mediaref_available_range(x)
    else cpp_available_range(x)
}

#' @rdname available_range
#' @export
`available_range<-` <- function(x, value) {
    cpp_mediaref_set_available_range(x, value)
    x
}

#' Trimmed range of an Item
#' @param x An \code{Item}.
#' @return A \code{TimeRange}: the source_range if set, else available_range.
#' @export
trimmed_range <- function(x) cpp_trimmed_range(x)

#' Visible range of an Item (including handles into transitions)
#' @param x An \code{Item}.
#' @return A \code{TimeRange}.
#' @export
visible_range <- function(x) cpp_visible_range(x)

#' Range of an Item within its parent
#'
#' This is where the item sits in its parent's time, the OTIO notion of
#' timeline position. There is no separately stored "in" point.
#'
#' @param x An \code{Item} or \code{Transition}.
#' @return A \code{TimeRange}. An object with no parent has no range there,
#'   so OTIO raises an error in that case (for both items and transitions).
#' @export
range_in_parent <- function(x) {
    if (inherits(x, "Transition")) cpp_transition_range_in_parent(x)
    else cpp_range_in_parent(x)
}

#' Trimmed range of an Item within its parent
#' @param x An \code{Item} or \code{Transition}.
#' @return A \code{TimeRange} or \code{NULL}.
#' @export
trimmed_range_in_parent <- function(x) {
    if (inherits(x, "Transition")) cpp_transition_trimmed_range_in_parent(x)
    else cpp_trimmed_range_in_parent(x)
}

#' Is a Composable visible?
#' @param x A \code{Composable}.
#' @return Logical.
#' @export
visible <- function(x) cpp_visible(x)

#' Does a Composable overlap its neighbours? (TRUE for transitions)
#' @param x A \code{Composable}.
#' @return Logical.
#' @export
overlapping <- function(x) cpp_overlapping(x)

#' Parent composition of a Composable
#' @param x A \code{Composable}.
#' @return The parent \code{Composition}, or \code{NULL} if unparented.
#' @export
parent <- function(x) cpp_parent(x)
