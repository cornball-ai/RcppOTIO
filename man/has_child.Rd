% tinyrox says don't edit this manually, but it can't stop you!
\name{has_child}
\alias{has_child}
\title{Does a composition directly contain a child?}
\usage{
has_child(x, child)
}
\arguments{
\item{x}{A \code{Composition}.}

\item{child}{A \code{Composable}.}
}
\value{
Logical.
}
\description{
Does a composition directly contain a child?
}
\examples{
library(rotio)
trk <- Track("V1")
a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
b <- Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(12, 24)))
append_child(trk, a)
has_child(trk, a)
has_child(trk, b)
}
