# Composition tree operations. Indices are 1-based at the R surface and
# converted to OTIO's 0-based indices at the boundary. Children are
# addressed by position and object reference, never by name.

#' Children of a composition
#' @param x A \code{Composition} (Track, Stack) or \code{SerializableCollection}.
#' @return A list of child OTIO objects, in order.
#' @examples
#' library(rotio)
#' trk <- Track("V1")
#' a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
#' append_child(trk, a)
#' length(children(trk))
#' name(children(trk)[[1]])
#' @export
children <- function(x) {
    if (inherits(x, "SerializableCollection")) cpp_collection_children(x)
    else cpp_children(x)
}

#' Append a child to a composition
#' @param x A \code{Composition}.
#' @param child A \code{Composable} to append.
#' @return \code{x}, invisibly.
#' @examples
#' library(rotio)
#' trk <- Track("V1")
#' a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
#' append_child(trk, a)
#' length(children(trk))
#' @export
append_child <- function(x, child) {
    cpp_append_child(x, child)
    invisible(x)
}

#' Insert a child at a position
#' @param x A \code{Composition} or \code{SerializableCollection}.
#' @param index 1-based position at which to insert.
#' @param child A \code{Composable} (Composition) or any OTIO object
#'   (SerializableCollection).
#' @return \code{x}, invisibly.
#' @examples
#' library(rotio)
#' trk <- Track("V1")
#' a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
#' b <- Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(12, 24)))
#' append_child(trk, a); append_child(trk, b)
#' insert_child(trk, 2, Gap(RationalTime(6, 24)))
#' length(children(trk))
#' @export
insert_child <- function(x, index, child) {
    if (inherits(x, "SerializableCollection")) {
        cpp_collection_insert_child(x, .to_otio_index(index), child)
    } else {
        cpp_insert_child(x, .to_otio_index(index), child)
    }
    invisible(x)
}

#' Replace the child at a position
#' @param x A \code{Composition} or \code{SerializableCollection}.
#' @param index 1-based position to replace.
#' @param child A \code{Composable} or OTIO object (see \code{insert_child}).
#' @return \code{x}, invisibly.
#' @examples
#' library(rotio)
#' trk <- Track("V1")
#' a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
#' b <- Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(12, 24)))
#' append_child(trk, a); append_child(trk, b)
#' c <- Clip("C", source_range = TimeRange(RationalTime(0, 24), RationalTime(6, 24)))
#' set_child(trk, 1, c)
#' name(children(trk)[[1]])
#' @export
set_child <- function(x, index, child) {
    if (inherits(x, "SerializableCollection")) {
        cpp_collection_set_child(x, .to_otio_index(index), child)
    } else {
        cpp_set_child(x, .to_otio_index(index), child)
    }
    invisible(x)
}

#' Remove the child at a position
#' @param x A \code{Composition} or \code{SerializableCollection}.
#' @param index 1-based position to remove.
#' @return \code{x}, invisibly.
#' @examples
#' library(rotio)
#' trk <- Track("V1")
#' a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
#' b <- Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(12, 24)))
#' append_child(trk, a); append_child(trk, b)
#' remove_child(trk, 1)
#' length(children(trk))
#' @export
remove_child <- function(x, index) {
    if (inherits(x, "SerializableCollection")) {
        cpp_collection_remove_child(x, .to_otio_index(index))
    } else {
        cpp_remove_child(x, .to_otio_index(index))
    }
    invisible(x)
}

#' Remove all children of a composition
#' @param x A \code{Composition} or \code{SerializableCollection}.
#' @return \code{x}, invisibly.
#' @examples
#' library(rotio)
#' trk <- Track("V1")
#' a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
#' append_child(trk, a)
#' clear_children(trk)
#' length(children(trk))
#' @export
clear_children <- function(x) {
    if (inherits(x, "SerializableCollection")) cpp_collection_clear_children(x)
    else cpp_clear_children(x)
    invisible(x)
}

#' Replace all children of a composition
#'
#' Available both as a function, \code{set_children(x, kids)}, and as a
#' replacement, \code{set_children(x) <- kids}.
#'
#' @param x A \code{Composition} or \code{SerializableCollection}.
#' @param children,value A list of OTIO objects (\code{Composable} for a
#'   Composition; any OTIO object for a SerializableCollection).
#' @return \code{x} (invisibly from the function form).
#' @examples
#' library(rotio)
#' trk <- Track("V1")
#' a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
#' b <- Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(12, 24)))
#' set_children(trk, list(a, b))
#' length(children(trk))
#' @export
set_children <- function(x, children) {
    if (inherits(x, "SerializableCollection")) cpp_collection_set_children(x, children)
    else cpp_set_children(x, children)
    invisible(x)
}

#' @rdname set_children
#' @export
`set_children<-` <- function(x, value) {
    set_children(x, value)
}

#' Position of a child within a composition
#' @param x A \code{Composition}.
#' @param child A \code{Composable}.
#' @return The 1-based index, or \code{NA} if not a child.
#' @examples
#' library(rotio)
#' trk <- Track("V1")
#' a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
#' b <- Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(12, 24)))
#' append_child(trk, a); append_child(trk, b)
#' index_of_child(trk, b)
#' @export
index_of_child <- function(x, child) {
    .from_otio_index(cpp_index_of_child(x, child))
}

#' Is one object a parent (ancestor) of another?
#' @param x A \code{Composition}.
#' @param other A \code{Composable}.
#' @return Logical.
#' @examples
#' library(rotio)
#' trk <- Track("V1")
#' a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
#' append_child(trk, a)
#' is_parent_of(trk, a)
#' @export
is_parent_of <- function(x, other) cpp_is_parent_of(x, other)

#' Does a composition directly contain a child?
#' @param x A \code{Composition}.
#' @param child A \code{Composable}.
#' @return Logical.
#' @examples
#' library(rotio)
#' trk <- Track("V1")
#' a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
#' b <- Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(12, 24)))
#' append_child(trk, a)
#' has_child(trk, a)
#' has_child(trk, b)
#' @export
has_child <- function(x, child) cpp_has_child(x, child)

#' Does a composition contain any clips (recursively)?
#' @param x A \code{Composition}.
#' @return Logical.
#' @examples
#' library(rotio)
#' trk <- Track("V1")
#' has_clips(trk)
#' a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
#' append_child(trk, a)
#' has_clips(trk)
#' @export
has_clips <- function(x) cpp_has_clips(x)

#' Find all clips within an object (recursively)
#' @param x A \code{Composition}, \code{Timeline}, or \code{SerializableCollection}.
#' @return A list of \code{Clip} objects.
#' @examples
#' library(rotio)
#' trk <- Track("V1")
#' a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
#' b <- Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(12, 24)))
#' append_child(trk, a); append_child(trk, b)
#' clips <- find_clips(trk)
#' length(clips)
#' @export
find_clips <- function(x) {
    if (inherits(x, "Timeline")) cpp_timeline_find_clips(x)
    else if (inherits(x, "SerializableCollection")) cpp_collection_find_clips(x)
    else cpp_find_clips(x)
}
