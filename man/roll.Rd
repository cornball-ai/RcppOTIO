% tinyrox says don't edit this manually, but it can't stop you!
\name{roll}
\alias{roll}
\title{Roll an edit point, trading duration with adjacent items}
\usage{
roll(item, delta_in, delta_out)
}
\arguments{
\item{item}{The \code{Item} to roll.}

\item{delta_in}{\code{RationalTime} added to the start time.}

\item{delta_out}{\code{RationalTime} added to the exclusive end time.}
}
\value{
\code{item}, invisibly.
}
\description{
Adjusts \code{item} and its neighbours' source ranges so the surrounding
items' parent boundaries do not move. No new items are created.
}
\examples{
library(RcppOTIO)
trk <- Track("V1", kind = "Video")
append_child(trk, Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
append_child(trk, Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
clip_a <- children(trk)[[1]]
roll(clip_a, RationalTime(0, 24), RationalTime(12, 24))
}
