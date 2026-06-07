% tinyrox says don't edit this manually, but it can't stop you!
\name{parent}
\alias{parent}
\title{Parent composition of a Composable}
\usage{
parent(x)
}
\arguments{
\item{x}{A \code{Composable}.}
}
\value{
The parent \code{Composition}, or \code{NULL} if unparented.
}
\description{
Parent composition of a Composable
}
\examples{
library(RcppOTIO)
trk <- Track("V1")
a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
append_child(trk, a)
name(parent(a))
}
