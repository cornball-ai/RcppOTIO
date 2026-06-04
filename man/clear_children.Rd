% tinyrox says don't edit this manually, but it can't stop you!
\name{clear_children}
\alias{clear_children}
\title{Remove all children of a composition}
\usage{
clear_children(x)
}
\arguments{
\item{x}{A \code{Composition} or \code{SerializableCollection}.}
}
\value{
\code{x}, invisibly.
}
\description{
Remove all children of a composition
}
\examples{
library(rotio)
trk <- Track("V1")
a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
append_child(trk, a)
clear_children(trk)
length(children(trk))
}
