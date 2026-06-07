% tinyrox says don't edit this manually, but it can't stop you!
\name{flatten_stack}
\alias{flatten_stack}
\title{Flatten a stack (or list of tracks) into a single track}
\usage{
flatten_stack(x)
}
\arguments{
\item{x}{A \code{Stack}, or a list of \code{Track} objects.}
}
\value{
A new \code{Track} with the layers composited top-down.
}
\description{
Flatten a stack (or list of tracks) into a single track
}
\examples{
library(RcppOTIO)
trk1 <- Track("V1", kind = "Video")
append_child(trk1, Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
trk2 <- Track("V2", kind = "Video")
append_child(trk2, Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
st <- Stack("root")
append_child(st, trk1)
append_child(st, trk2)
flat <- flatten_stack(st)
}
