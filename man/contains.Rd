% tinyrox says don't edit this manually, but it can't stop you!
\name{contains}
\alias{contains}
\title{Does a TimeRange contain a time or range?}
\usage{
contains(tr, other, epsilon_s = 1/384000)
}
\arguments{
\item{tr}{A \code{TimeRange}.}

\item{other}{A \code{RationalTime} or \code{TimeRange}.}

\item{epsilon_s}{Tolerance in seconds (range comparison only).}
}
\value{
Logical.
}
\description{
For a \code{RationalTime}, containment is half-open: the start is
included, the exclusive end is not. For a \code{TimeRange}, OTIO is
strict at both edges, so a range sharing a boundary with \code{tr} is
not contained; only strictly-interior ranges are.
}
\examples{
tr <- TimeRange(RationalTime(0, 24), RationalTime(48, 24))
contains(tr, RationalTime(24, 24))
contains(tr, TimeRange(RationalTime(12, 24), RationalTime(12, 24)))
}
