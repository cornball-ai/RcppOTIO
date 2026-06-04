% tinyrox says don't edit this manually, but it can't stop you!
\name{is_parent_of}
\alias{is_parent_of}
\title{Is one object a parent (ancestor) of another?}
\usage{
is_parent_of(x, other)
}
\arguments{
\item{x}{A \code{Composition}.}

\item{other}{A \code{Composable}.}
}
\value{
Logical.
}
\description{
Is one object a parent (ancestor) of another?
}
\examples{
library(rotio)
trk <- Track("V1")
a <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
append_child(trk, a)
is_parent_of(trk, a)
}
