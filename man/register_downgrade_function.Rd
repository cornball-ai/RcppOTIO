% tinyrox says don't edit this manually, but it can't stop you!
\name{register_downgrade_function}
\alias{register_downgrade_function}
\title{Register a schema downgrade function}
\usage{
register_downgrade_function(schema_name, version_to_downgrade_from, fn)
}
\arguments{
\item{schema_name}{The schema to downgrade (must be a registered schema).}

\item{version_to_downgrade_from}{The integer version this function
downgrades from.}

\item{fn}{A function taking the schema dictionary (a named list) and
returning the modified named list.}
}
\value{
\code{TRUE} if registered; \code{FALSE} if a function is already
  registered for this \code{(schema_name, version)} pair or the schema is
  not registered.
}
\description{
The function is run when serializing with a target schema version below
the object's current version. It downgrades the dictionary from
\code{version_to_downgrade_from} to \code{version_to_downgrade_from - 1}.
}
\examples{
library(rotio)
# Register an identity downgrade for Gap from version 9.
result <- register_downgrade_function("Gap", 9L, function(d) d)
is.logical(result)
}
