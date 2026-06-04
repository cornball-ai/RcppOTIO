% tinyrox says don't edit this manually, but it can't stop you!
\name{append_child}
\alias{append_child}
\title{Append a child to a composition}
\usage{
append_child(x, child)
}
\arguments{
\item{x}{A \code{Composition}.}

\item{child}{A \code{Composable} to append.}
}
\value{
\code{x}, invisibly.
}
\description{
Append a child to a composition
}
\examples{
library(rotio)
trk <- Track("V1")
a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
append_child(trk, a)
length(children(trk))
}
