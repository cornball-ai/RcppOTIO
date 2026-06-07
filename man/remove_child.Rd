% tinyrox says don't edit this manually, but it can't stop you!
\name{remove_child}
\alias{remove_child}
\title{Remove the child at a position}
\usage{
remove_child(x, index)
}
\arguments{
\item{x}{A \code{Composition} or \code{SerializableCollection}.}

\item{index}{1-based position to remove.}
}
\value{
\code{x}, invisibly.
}
\description{
Remove the child at a position
}
\examples{
library(RcppOTIO)
trk <- Track("V1")
a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
b <- Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(12, 24)))
append_child(trk, a); append_child(trk, b)
remove_child(trk, 1)
length(children(trk))
}
