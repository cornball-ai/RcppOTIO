% tinyrox says don't edit this manually, but it can't stop you!
\name{TimeRange}
\alias{TimeRange}
\title{TimeRange}
\usage{
TimeRange(start_time = RationalTime(), duration = RationalTime())
}
\arguments{
\item{start_time}{A \code{RationalTime}.}

\item{duration}{A \code{RationalTime}.}
}
\value{
A \code{TimeRange}.
}
\description{
A span with a start time and a duration. Stored as a classed list with
elements \code{start_time} and \code{duration}, each a
\code{RationalTime}.
}
