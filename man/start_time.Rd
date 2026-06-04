% tinyrox says don't edit this manually, but it can't stop you!
\name{start_time}
\alias{start_time}
\title{TimeRange start and duration accessors}
\usage{
start_time(tr)
}
\arguments{
\item{tr}{A \code{TimeRange}.}
}
\value{
A \code{RationalTime}.
}
\description{
TimeRange start and duration accessors
}
\examples{
start_time(TimeRange(RationalTime(12, 24), RationalTime(24, 24)))
}
