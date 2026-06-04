% tinyrox says don't edit this manually, but it can't stop you!
\name{register_upgrade_function}
\alias{register_upgrade_function}
\title{Register a schema upgrade function}
\usage{
register_upgrade_function(schema_name, version_to_upgrade_to, fn)
}
\arguments{
\item{schema_name}{The schema to upgrade (must be a registered schema).}

\item{version_to_upgrade_to}{The integer version this function upgrades to.}

\item{fn}{A function taking the schema dictionary (a named list) and
returning the modified named list.}
}
\value{
\code{TRUE} if registered; \code{FALSE} if a function is already
  registered for this \code{(schema_name, version)} pair or the schema is
  not registered.
}
\description{
The function is run, in registration order, when deserializing an object
whose stored schema version is older than \code{version_to_upgrade_to}.
Each upgrade function should bring the dictionary from the version just
below \code{version_to_upgrade_to} up to it.
}
\examples{
library(rotio)
# Register an identity upgrade for Timeline to version 9.
# Returns TRUE on the first call; FALSE if already registered.
result <- register_upgrade_function("Timeline", 9L, function(d) d)
is.logical(result)
}
