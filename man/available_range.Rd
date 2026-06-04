% tinyrox says don't edit this manually, but it can't stop you!
\name{available_range}
\alias{available_range}
\alias{available_range<-}
\title{Available range}
\usage{
available_range(x)

available_range(x) <- value
}
\arguments{
\item{x}{An \code{Item} or \code{MediaReference}.}

\item{value}{A \code{TimeRange} or \code{NULL} (MediaReference only).}
}
\value{
A \code{TimeRange} (or \code{NULL} for an unset media range);
  the setter returns \code{x}.
}
\description{
For an \code{Item} the range available to be trimmed; for a
\code{MediaReference} the range of the underlying media.
}
