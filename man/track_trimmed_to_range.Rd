% tinyrox says don't edit this manually, but it can't stop you!
\name{track_trimmed_to_range}
\alias{track_trimmed_to_range}
\title{Return a copy of a track trimmed to a range}
\usage{
track_trimmed_to_range(in_track, trim_range)
}
\arguments{
\item{in_track}{The source \code{Track} (not modified).}

\item{trim_range}{The \code{TimeRange} to trim to.}
}
\value{
A new \code{Track}.
}
\description{
Return a copy of a track trimmed to a range
}
\examples{
library(RcppOTIO)
trk <- Track("V1", kind = "Video")
append_child(trk, Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
append_child(trk, Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
trimmed <- track_trimmed_to_range(trk, TimeRange(RationalTime(24, 24), RationalTime(48, 24)))
}
