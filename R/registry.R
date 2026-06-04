# TypeRegistry schema upgrade/downgrade hooks.
#
# Upgrade/downgrade functions take the schema as a named list and return
# the modified named list. Upgrade functions run during deserialization
# when a stored object's schema version is older than the registered
# version; downgrade functions run during serialization when
# to_json_string(target_schema_versions = ...) requests an older version.
#
# The registered function is retained for the rest of the session (the
# OTIO TypeRegistry is a process-global singleton with no unregister API),
# so keep it self-contained. It must not raise an R error while OTIO is
# mid-(de)serialization.

# Coerce a named integer vector of schema -> version to the form the C++
# layer expects, or pass NULL through unchanged.
.as_schema_versions <- function(x) {
    if (is.null(x)) return(NULL)
    nm <- names(x)
    if (is.null(nm) || anyNA(nm) || any(!nzchar(nm)))
        stop("target_schema_versions must be a named integer vector (schema -> version)")
    if (anyDuplicated(nm))
        stop("target_schema_versions has duplicate schema names")
    if (!is.numeric(x))
        stop("target_schema_versions versions must be whole numbers")
    if (anyNA(x))
        stop("target_schema_versions versions must not be NA")
    if (any(x != floor(x)))
        stop("target_schema_versions versions must be whole numbers")
    v <- as.integer(x)
    names(v) <- nm
    v
}

#' Register a schema upgrade function
#'
#' The function is run, in registration order, when deserializing an object
#' whose stored schema version is older than \code{version_to_upgrade_to}.
#' Each upgrade function should bring the dictionary from the version just
#' below \code{version_to_upgrade_to} up to it.
#'
#' @param schema_name The schema to upgrade (must be a registered schema).
#' @param version_to_upgrade_to The integer version this function upgrades to.
#' @param fn A function taking the schema dictionary (a named list) and
#'   returning the modified named list.
#' @return \code{TRUE} if registered; \code{FALSE} if a function is already
#'   registered for this \code{(schema_name, version)} pair or the schema is
#'   not registered.
#' @export
register_upgrade_function <- function(schema_name, version_to_upgrade_to, fn) {
    cpp_register_upgrade_function(schema_name, as.integer(version_to_upgrade_to), fn)
}

#' Register a schema downgrade function
#'
#' The function is run when serializing with a target schema version below
#' the object's current version. It downgrades the dictionary from
#' \code{version_to_downgrade_from} to \code{version_to_downgrade_from - 1}.
#'
#' @param schema_name The schema to downgrade (must be a registered schema).
#' @param version_to_downgrade_from The integer version this function
#'   downgrades from.
#' @param fn A function taking the schema dictionary (a named list) and
#'   returning the modified named list.
#' @return \code{TRUE} if registered; \code{FALSE} if a function is already
#'   registered for this \code{(schema_name, version)} pair or the schema is
#'   not registered.
#' @export
register_downgrade_function <- function(schema_name, version_to_downgrade_from, fn) {
    cpp_register_downgrade_function(schema_name, as.integer(version_to_downgrade_from), fn)
}

#' Registered schema names and their current versions
#'
#' @return A named integer vector mapping schema name to current version.
#' @export
type_version_map <- function() cpp_type_version_map()
