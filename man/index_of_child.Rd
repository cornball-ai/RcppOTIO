% tinyrox says don't edit this manually, but it can't stop you!
\name{index_of_child}
\alias{index_of_child}
\title{Position of a child within a composition}
\usage{
index_of_child(x, child)
}
\arguments{
\item{x}{A \code{Composition}.}

\item{child}{A \code{Composable}.}
}
\value{
The 1-based index, or \code{NA} if not a child.
}
\description{
Position of a child within a composition
}
\examples{
library(RcppOTIO)
trk <- Track("V1")
a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
b <- Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(12, 24)))
append_child(trk, a); append_child(trk, b)
index_of_child(trk, b)
}
