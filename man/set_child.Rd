% tinyrox says don't edit this manually, but it can't stop you!
\name{set_child}
\alias{set_child}
\title{Replace the child at a position}
\usage{
set_child(x, index, child)
}
\arguments{
\item{x}{A \code{Composition} or \code{SerializableCollection}.}

\item{index}{1-based position to replace.}

\item{child}{A \code{Composable} or OTIO object (see \code{insert_child}).}
}
\value{
\code{x}, invisibly.
}
\description{
Replace the child at a position
}
\examples{
library(RcppOTIO)
trk <- Track("V1")
a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
b <- Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(12, 24)))
append_child(trk, a); append_child(trk, b)
c <- Clip("C", source_range = TimeRange(RationalTime(0, 24), RationalTime(6, 24)))
set_child(trk, 1, c)
name(children(trk)[[1]])
}
