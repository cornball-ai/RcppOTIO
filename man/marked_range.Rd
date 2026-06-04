% tinyrox says don't edit this manually, but it can't stop you!
\name{marked_range}
\alias{marked_range}
\alias{marked_range<-}
\title{Marked range of a Marker}
\usage{
marked_range(x)

marked_range(x) <- value
}
\arguments{
\item{x}{A \code{Marker}.}

\item{value}{A \code{TimeRange}.}
}
\value{
A \code{TimeRange}; the setter returns \code{x}.
}
\description{
Marked range of a Marker
}
\examples{
m <- Marker("m", marked_range = TimeRange(RationalTime(0, 24), RationalTime(1, 24)),
  color = "RED")
marked_range(m)
}
