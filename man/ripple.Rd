% tinyrox says don't edit this manually, but it can't stop you!
\name{ripple}
\alias{ripple}
\title{Ripple an item's in/out, shifting everything after it}
\usage{
ripple(item, delta_in, delta_out)
}
\arguments{
\item{item}{The \code{Item} to ripple.}

\item{delta_in}{\code{RationalTime} added to the start time.}

\item{delta_out}{\code{RationalTime} added to the exclusive end time.}
}
\value{
\code{item}, invisibly.
}
\description{
Adjusts \code{item}'s \code{source_range}; later items move to stay
adjacent (no new items created).
}
\examples{
library(rotio)
trk <- Track("V1", kind = "Video")
append_child(trk, Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
append_child(trk, Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
clip_a <- children(trk)[[1]]
ripple(clip_a, RationalTime(0, 24), RationalTime(-12, 24))
}
