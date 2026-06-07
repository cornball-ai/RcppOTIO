% tinyrox says don't edit this manually, but it can't stop you!
\name{source_range}
\alias{source_range}
\alias{source_range<-}
\title{Source range of an Item}
\usage{
source_range(x)

source_range(x) <- value
}
\arguments{
\item{x}{An \code{Item} (Clip, Gap, Track, Stack).}

\item{value}{A \code{TimeRange} or \code{NULL}.}
}
\value{
A \code{TimeRange} or \code{NULL}; the setter returns \code{x}.
}
\description{
The stored trim of an item, as a \code{TimeRange}, or \code{NULL} if
unset. This is the item's own extent, not its position in a parent
(use \code{range_in_parent}).
}
\examples{
library(RcppOTIO)
clip <- Clip("A")
source_range(clip) <- TimeRange(RationalTime(0, 24), RationalTime(24, 24))
source_range(clip)
}
