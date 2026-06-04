# OTIO edit algorithms and composition algorithms. Names follow OTIO
# exactly. The edit algorithms mutate a composition (or an item already in
# one) in place and return the mutated object invisibly;
# track_trimmed_to_range and flatten_stack return new objects.
#
# fill_template defaults to NULL, which is OTIO's own default (the
# algorithm synthesises gaps itself). Pass an Item only when you want a
# specific fill; do not pass an empty Gap() expecting the default.
#
# Note: overwrite, insert, slice, fill, trim, and remove are collision-
# prone names, and remove in particular masks base::remove (alias of rm)
# when the package is attached. Use rotio::remove / base::remove to
# disambiguate. See ?`rotio-package`.

#' Overwrite a span of a composition with an item
#'
#' Places \code{item} over \code{range} in \code{composition}, partitioning
#' or gap-filling existing items as needed.
#'
#' @param item The \code{Item} to write in (usually a \code{Clip}).
#' @param composition The target \code{Composition} (usually a \code{Track}).
#' @param range The \code{TimeRange} to overwrite.
#' @param remove_transitions Whether to drop transitions within \code{range}.
#' @param fill_template Optional \code{Item} used to fill gaps; \code{NULL}
#'   uses OTIO's default gap synthesis.
#' @return \code{composition}, invisibly.
#' @export
overwrite <- function(item, composition, range,
                      remove_transitions = TRUE, fill_template = NULL) {
    cpp_algo_overwrite(item, composition, range, remove_transitions, fill_template)
    invisible(composition)
}

#' Insert an item at a time, splitting whatever is there
#'
#' @param item The \code{Item} to insert (usually a \code{Clip}).
#' @param composition The target \code{Composition} (usually a \code{Track}).
#' @param time The \code{RationalTime} to insert at. Before the start inserts
#'   at index 0; past the end appends.
#' @param remove_transitions Whether to drop transitions intersecting \code{time}.
#' @param fill_template Optional \code{Item} to fill any gap when \code{time}
#'   is past the composition's end; \code{NULL} uses OTIO's default.
#' @return \code{composition}, invisibly.
#' @export
insert <- function(item, composition, time,
                   remove_transitions = TRUE, fill_template = NULL) {
    cpp_algo_insert(item, composition, time, remove_transitions, fill_template)
    invisible(composition)
}

#' Trim an item's in/out points, filling the vacated time
#'
#' Adjusts a single item's \code{source_range} without moving other items;
#' the now-empty time is filled with a gap (or \code{fill_template}), or an
#' adjacent gap is grown.
#'
#' @param item The \code{Item} to trim.
#' @param delta_in \code{RationalTime} added to the start time.
#' @param delta_out \code{RationalTime} added to the exclusive end time.
#' @param fill_template Optional \code{Item} to fill with; \code{NULL} uses a gap.
#' @return \code{item}, invisibly.
#' @export
trim <- function(item, delta_in, delta_out, fill_template = NULL) {
    cpp_algo_trim(item, delta_in, delta_out, fill_template)
    invisible(item)
}

#' Slice a composition in two at a time
#'
#' Splits whatever item covers \code{time} into two adjacent items.
#'
#' @param composition The \code{Composition} (usually a \code{Track}).
#' @param time The \code{RationalTime} to slice at.
#' @param remove_transitions Whether to drop transitions at \code{time}.
#' @return \code{composition}, invisibly.
#' @export
slice <- function(composition, time, remove_transitions = TRUE) {
    cpp_algo_slice(composition, time, remove_transitions)
    invisible(composition)
}

#' Slip an item's source in/out by a delta, keeping its duration and position
#'
#' Shifts which part of the media is shown; clamped to the available range
#' when known. Other items are unaffected.
#'
#' @param item The \code{Item} to slip.
#' @param delta \code{RationalTime} to slip by (positive or negative).
#' @return \code{item}, invisibly.
#' @export
slip <- function(item, delta) {
    cpp_algo_slip(item, delta)
    invisible(item)
}

#' Slide an item, absorbing the change into the previous item's duration
#'
#' Moves \code{item}'s start, growing or shrinking the previous item. Does
#' nothing if \code{item} is first.
#'
#' @param item The \code{Item} to slide.
#' @param delta \code{RationalTime} to slide by.
#' @return \code{item}, invisibly.
#' @export
slide <- function(item, delta) {
    cpp_algo_slide(item, delta)
    invisible(item)
}

#' Ripple an item's in/out, shifting everything after it
#'
#' Adjusts \code{item}'s \code{source_range}; later items move to stay
#' adjacent (no new items created).
#'
#' @param item The \code{Item} to ripple.
#' @param delta_in \code{RationalTime} added to the start time.
#' @param delta_out \code{RationalTime} added to the exclusive end time.
#' @return \code{item}, invisibly.
#' @export
ripple <- function(item, delta_in, delta_out) {
    cpp_algo_ripple(item, delta_in, delta_out)
    invisible(item)
}

#' Roll an edit point, trading duration with adjacent items
#'
#' Adjusts \code{item} and its neighbours' source ranges so the surrounding
#' items' parent boundaries do not move. No new items are created.
#'
#' @param item The \code{Item} to roll.
#' @param delta_in \code{RationalTime} added to the start time.
#' @param delta_out \code{RationalTime} added to the exclusive end time.
#' @return \code{item}, invisibly.
#' @export
roll <- function(item, delta_in, delta_out) {
    cpp_algo_roll(item, delta_in, delta_out)
    invisible(item)
}

#' Fill an item into a track at a time (3/4-point edit)
#'
#' @param item The \code{Item} to place (usually a \code{Clip}).
#' @param track The \code{Composition} that will own the item.
#' @param track_time The \code{RationalTime} to place it at.
#' @param reference_point One of \code{"Source"}, \code{"Sequence"}, or
#'   \code{"Fit"}, controlling the transform for 4-point editing.
#' @return \code{track}, invisibly.
#' @export
fill <- function(item, track, track_time, reference_point = "Source") {
    cpp_algo_fill(item, track, track_time, reference_point)
    invisible(track)
}

#' Remove the item at a time, optionally leaving a gap
#'
#' Masks \code{base::remove}; use \code{rotio::remove} / \code{base::remove}
#' to disambiguate.
#'
#' @param composition The \code{Composition} to remove from.
#' @param time The \code{RationalTime} locating the item to remove.
#' @param fill If \code{TRUE} (default) leave a gap (or \code{fill_template});
#'   if \code{FALSE} concatenate the neighbours.
#' @param fill_template Optional \code{Item} to fill with; \code{NULL} uses a gap.
#' @return \code{composition}, invisibly.
#' @export
remove <- function(composition, time, fill = TRUE, fill_template = NULL) {
    cpp_algo_remove(composition, time, fill, fill_template)
    invisible(composition)
}

# ---- Composition algorithms ------------------------------------------

#' Return a copy of a track trimmed to a range
#'
#' @param in_track The source \code{Track} (not modified).
#' @param trim_range The \code{TimeRange} to trim to.
#' @return A new \code{Track}.
#' @export
track_trimmed_to_range <- function(in_track, trim_range) {
    cpp_track_trimmed_to_range(in_track, trim_range)
}

#' Flatten a stack (or list of tracks) into a single track
#'
#' @param x A \code{Stack}, or a list of \code{Track} objects.
#' @return A new \code{Track} with the layers composited top-down.
#' @export
flatten_stack <- function(x) {
    if (inherits(x, "Stack")) cpp_flatten_stack(x)
    else if (is.list(x)) cpp_flatten_stack_tracks(x)
    else stop("flatten_stack() expects a Stack or a list of Track objects")
}
