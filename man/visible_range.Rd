% tinyrox says don't edit this manually, but it can't stop you!
\name{visible_range}
\alias{visible_range}
\title{Visible range of an Item (including handles into transitions)}
\usage{
visible_range(x)
}
\arguments{
\item{x}{An \code{Item}.}
}
\value{
A \code{TimeRange}.
}
\description{
Visible range of an Item (including handles into transitions)
}
\examples{
library(RcppOTIO)
trk <- Track("V1")
a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
append_child(trk, a)
visible_range(a)
}
