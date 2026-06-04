% tinyrox says don't edit this manually, but it can't stop you!
\name{insert_child}
\alias{insert_child}
\title{Insert a child at a position}
\usage{
insert_child(x, index, child)
}
\arguments{
\item{x}{A \code{Composition} or \code{SerializableCollection}.}

\item{index}{1-based position at which to insert.}

\item{child}{A \code{Composable} (Composition) or any OTIO object
(SerializableCollection).}
}
\value{
\code{x}, invisibly.
}
\description{
Insert a child at a position
}
\examples{
library(rotio)
trk <- Track("V1")
a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
b <- Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(12, 24)))
append_child(trk, a); append_child(trk, b)
insert_child(trk, 2, Gap(RationalTime(6, 24)))
length(children(trk))
}
