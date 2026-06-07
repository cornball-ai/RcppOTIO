% tinyrox says don't edit this manually, but it can't stop you!
\name{trim}
\alias{trim}
\title{Trim an item's in/out points, filling the vacated time}
\usage{
trim(item, delta_in, delta_out, fill_template = NULL)
}
\arguments{
\item{item}{The \code{Item} to trim.}

\item{delta_in}{\code{RationalTime} added to the start time.}

\item{delta_out}{\code{RationalTime} added to the exclusive end time.}

\item{fill_template}{Optional \code{Item} to fill with; \code{NULL} uses a gap.}
}
\value{
\code{item}, invisibly.
}
\description{
Adjusts a single item's \code{source_range} without moving other items;
the now-empty time is filled with a gap (or \code{fill_template}), or an
adjacent gap is grown.
}
\examples{
library(RcppOTIO)
trk <- Track("V1", kind = "Video")
append_child(trk, Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
append_child(trk, Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
clip_a <- children(trk)[[1]]
trim(clip_a, RationalTime(12, 24), RationalTime(0, 24))
}
