% tinyrox says don't edit this manually, but it can't stop you!
\name{children}
\alias{children}
\title{Children of a composition}
\usage{
children(x)
}
\arguments{
\item{x}{A \code{Composition} (Track, Stack) or \code{SerializableCollection}.}
}
\value{
A list of child OTIO objects, in order.
}
\description{
Children of a composition
}
\examples{
library(RcppOTIO)
trk <- Track("V1")
a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
append_child(trk, a)
length(children(trk))
name(children(trk)[[1]])
}
