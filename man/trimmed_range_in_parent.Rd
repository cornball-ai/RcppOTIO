% tinyrox says don't edit this manually, but it can't stop you!
\name{trimmed_range_in_parent}
\alias{trimmed_range_in_parent}
\title{Trimmed range of an Item within its parent}
\usage{
trimmed_range_in_parent(x)
}
\arguments{
\item{x}{An \code{Item} or \code{Transition}.}
}
\value{
A \code{TimeRange} or \code{NULL}.
}
\description{
Trimmed range of an Item within its parent
}
\examples{
library(rotio)
trk <- Track("V1")
a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
append_child(trk, a)
trimmed_range_in_parent(a)
}
