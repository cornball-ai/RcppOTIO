# Methods common to every SerializableObject: JSON round-trip, clone,
# schema identity, name/metadata, and a print method.

#' Serialize an OTIO object to a JSON string
#'
#' @param x An OTIO object.
#' @param indent Indentation width (spaces).
#' @param target_schema_versions Optional named integer vector mapping
#'   schema names to target versions (e.g. \code{c(Clip = 1L)}). When
#'   supplied, OTIO downgrades each object to the requested version using
#'   the registered downgrade functions.
#' @return A JSON string in OTIO's vocabulary.
#' @export
to_json_string <- function(x, indent = 4L, target_schema_versions = NULL) {
    cpp_to_json_string(x, as.integer(indent), .as_schema_versions(target_schema_versions))
}

#' Write an OTIO object to a JSON file
#' @param x An OTIO object.
#' @param file_name Destination path.
#' @param indent Indentation width (spaces).
#' @param target_schema_versions Optional named integer vector of schema
#'   downgrade targets; see \code{\link{to_json_string}}.
#' @return \code{TRUE} on success (invisibly).
#' @export
to_json_file <- function(x, file_name, indent = 4L, target_schema_versions = NULL) {
    invisible(cpp_to_json_file(x, file_name, as.integer(indent),
                               .as_schema_versions(target_schema_versions)))
}

#' Read an OTIO object from a JSON string
#' @param input A JSON string.
#' @return The deserialized OTIO object.
#' @export
from_json_string <- function(input) cpp_from_json_string(input)

#' Read an OTIO object from a JSON file
#' @param file_name Source path.
#' @return The deserialized OTIO object.
#' @export
from_json_file <- function(file_name) cpp_from_json_file(file_name)

#' Deep-clone an OTIO object
#' @param x An OTIO object.
#' @return An independent copy.
#' @export
clone <- function(x) cpp_clone(x)

#' Schema name and version of an OTIO object
#' @param x An OTIO object.
#' @return The schema name (string) or version (integer).
#' @export
schema_name <- function(x) cpp_schema_name(x)

#' @rdname schema_name
#' @export
schema_version <- function(x) cpp_schema_version(x)

#' Object-value equivalence (not pointer identity)
#' @param x,other OTIO objects.
#' @return Logical.
#' @export
is_equivalent_to <- function(x, other) cpp_is_equivalent_to(x, other)

#' Was this object loaded from an unknown schema?
#' @param x An OTIO object.
#' @return Logical.
#' @export
is_unknown_schema <- function(x) cpp_is_unknown_schema(x)

#' Name of an OTIO object
#'
#' \code{name} is descriptive metadata, not identity: siblings may share a
#' name. Address tree children by position and reference instead.
#'
#' @param x An OTIO object (with metadata).
#' @param value New name.
#' @return The name string; the setter returns \code{x}.
#' @export
name <- function(x) cpp_name(x)

#' @rdname name
#' @export
`name<-` <- function(x, value) {
    cpp_set_name(x, value)
    x
}

#' Metadata dictionary of an OTIO object
#'
#' Metadata is a named list. Supported value types are logical, integer,
#' double, and character scalars/vectors, the OTIO time types, nested
#' named lists (sub-dictionaries), unnamed lists (vectors), and OTIO
#' objects. Other value types are dropped with a warning on read.
#'
#' @param x An OTIO object (with metadata).
#' @param value A named list.
#' @return The metadata list; the setter returns \code{x}.
#' @export
metadata <- function(x) cpp_metadata(x)

#' @rdname metadata
#' @export
`metadata<-` <- function(x, value) {
    cpp_set_metadata(x, value)
    x
}

#' @export
print.otio <- function(x, ...) {
    nm <- tryCatch(cpp_name(x), error = function(e) NA_character_)
    schema <- tryCatch(sprintf("%s.%d", cpp_schema_name(x), cpp_schema_version(x)),
                       error = function(e) class(x)[1])
    label <- if (!is.na(nm) && nzchar(nm)) sprintf(" '%s'", nm) else ""
    cat(sprintf("<%s%s> [%s]\n", class(x)[1], label, schema))
    invisible(x)
}
