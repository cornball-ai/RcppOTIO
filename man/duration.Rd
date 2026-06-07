% tinyrox says don't edit this manually, but it can't stop you!
\name{duration}
\alias{duration}
\title{Duration of an object}
\usage{
duration(x)
}
\arguments{
\item{x}{A \code{TimeRange}, \code{Timeline}, or \code{Composable}.}
}
\value{
A \code{RationalTime}.
}
\description{
For a \code{TimeRange} this is its \code{duration} field; for a
\code{Timeline} the duration of its tracks; for a \code{Composable}
(Item, Clip, Track, ...) the computed duration.
}
\examples{
library(RcppOTIO)
clip <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
to_seconds(duration(clip))
}
