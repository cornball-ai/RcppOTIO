% tinyrox says don't edit this manually, but it can't stop you!
\name{fill}
\alias{fill}
\title{Fill an item into a track at a time (3/4-point edit)}
\usage{
fill(item, track, track_time, reference_point = "Source")
}
\arguments{
\item{item}{The \code{Item} to place (usually a \code{Clip}).}

\item{track}{The \code{Composition} that will own the item.}

\item{track_time}{The \code{RationalTime} to place it at.}

\item{reference_point}{One of \code{"Source"}, \code{"Sequence"}, or
\code{"Fit"}, controlling the transform for 4-point editing.}
}
\value{
\code{track}, invisibly.
}
\description{
Fill an item into a track at a time (3/4-point edit)
}
\examples{
library(rotio)
trk <- Track("V1", kind = "Video")
append_child(trk, Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24))))
append_child(trk, Gap(RationalTime(24, 24)))
append_child(trk, Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24))))
new_clip <- Clip("C", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
fill(new_clip, trk, RationalTime(24, 24))
}
