% tinyrox says don't edit this manually, but it can't stop you!
\name{has_clips}
\alias{has_clips}
\title{Does a composition contain any clips (recursively)?}
\usage{
has_clips(x)
}
\arguments{
\item{x}{A \code{Composition}.}
}
\value{
Logical.
}
\description{
Does a composition contain any clips (recursively)?
}
\examples{
library(rotio)
trk <- Track("V1")
has_clips(trk)
a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
append_child(trk, a)
has_clips(trk)
}
