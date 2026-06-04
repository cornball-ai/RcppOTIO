% tinyrox says don't edit this manually, but it can't stop you!
\name{find_clips}
\alias{find_clips}
\title{Find all clips within an object (recursively)}
\usage{
find_clips(x)
}
\arguments{
\item{x}{A \code{Composition}, \code{Timeline}, or \code{SerializableCollection}.}
}
\value{
A list of \code{Clip} objects.
}
\description{
Find all clips within an object (recursively)
}
\examples{
library(rotio)
trk <- Track("V1")
a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
b <- Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(12, 24)))
append_child(trk, a); append_child(trk, b)
clips <- find_clips(trk)
length(clips)
}
