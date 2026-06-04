% tinyrox says don't edit this manually, but it can't stop you!
\name{slice}
\alias{slice}
\title{Slice a composition in two at a time}
\usage{
slice(composition, time, remove_transitions = TRUE)
}
\arguments{
\item{composition}{The \code{Composition} (usually a \code{Track}).}

\item{time}{The \code{RationalTime} to slice at.}

\item{remove_transitions}{Whether to drop transitions at \code{time}.}
}
\value{
\code{composition}, invisibly.
}
\description{
Splits whatever item covers \code{time} into two adjacent items.
}
\examples{
library(rotio)
trk <- Track("V1", kind = "Video")
append_child(trk, Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
append_child(trk, Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
slice(trk, RationalTime(24, 24))
length(children(trk))  # 3 after the split
}
