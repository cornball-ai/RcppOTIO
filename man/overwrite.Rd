% tinyrox says don't edit this manually, but it can't stop you!
\name{overwrite}
\alias{overwrite}
\title{Overwrite a span of a composition with an item}
\usage{
overwrite(item, composition, range, remove_transitions = TRUE,
          fill_template = NULL)
}
\arguments{
\item{item}{The \code{Item} to write in (usually a \code{Clip}).}

\item{composition}{The target \code{Composition} (usually a \code{Track}).}

\item{range}{The \code{TimeRange} to overwrite.}

\item{remove_transitions}{Whether to drop transitions within \code{range}.}

\item{fill_template}{Optional \code{Item} used to fill gaps; \code{NULL}
uses OTIO's default gap synthesis.}
}
\value{
\code{composition}, invisibly.
}
\description{
Places \code{item} over \code{range} in \code{composition}, partitioning
or gap-filling existing items as needed.
}
\examples{
library(RcppOTIO)
trk <- Track("V1", kind = "Video")
append_child(trk, Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
append_child(trk, Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
new_clip <- Clip("C", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
overwrite(new_clip, trk, TimeRange(RationalTime(24, 24), RationalTime(24, 24)))
}
