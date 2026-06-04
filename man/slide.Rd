% tinyrox says don't edit this manually, but it can't stop you!
\name{slide}
\alias{slide}
\title{Slide an item, absorbing the change into the previous item's duration}
\usage{
slide(item, delta)
}
\arguments{
\item{item}{The \code{Item} to slide.}

\item{delta}{\code{RationalTime} to slide by.}
}
\value{
\code{item}, invisibly.
}
\description{
Moves \code{item}'s start, growing or shrinking the previous item. Does
nothing if \code{item} is first.
}
\examples{
library(rotio)
trk <- Track("V1", kind = "Video")
append_child(trk, Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
append_child(trk, Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
clip_b <- children(trk)[[2]]
slide(clip_b, RationalTime(12, 24))
}
