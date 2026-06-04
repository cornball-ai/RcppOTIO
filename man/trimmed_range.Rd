% tinyrox says don't edit this manually, but it can't stop you!
\name{trimmed_range}
\alias{trimmed_range}
\title{Trimmed range of an Item}
\usage{
trimmed_range(x)
}
\arguments{
\item{x}{An \code{Item}.}
}
\value{
A \code{TimeRange}: the source_range if set, else available_range.
}
\description{
Trimmed range of an Item
}
\examples{
library(rotio)
clip <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
trimmed_range(clip)
}
