% tinyrox says don't edit this manually, but it can't stop you!
\name{slip}
\alias{slip}
\title{Slip an item's source in/out by a delta, keeping its duration and position}
\usage{
slip(item, delta)
}
\arguments{
\item{item}{The \code{Item} to slip.}

\item{delta}{\code{RationalTime} to slip by (positive or negative).}
}
\value{
\code{item}, invisibly.
}
\description{
Shifts which part of the media is shown; clamped to the available range
when known. Other items are unaffected.
}
\examples{
library(rotio)
ref <- ExternalReference("a.mov",
  available_range = TimeRange(RationalTime(0, 24), RationalTime(96, 24)))
clip <- Clip("A", media_reference = ref,
  source_range = TimeRange(RationalTime(24, 24), RationalTime(24, 24)))
trk <- Track("V1", kind = "Video")
append_child(trk, clip)
slip(clip, RationalTime(-12, 24))
}
