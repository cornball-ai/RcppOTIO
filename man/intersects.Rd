% tinyrox says don't edit this manually, but it can't stop you!
\name{intersects}
\alias{intersects}
\title{Do two TimeRanges intersect?}
\usage{
intersects(tr, other, epsilon_s = 1/384000)
}
\arguments{
\item{epsilon_s}{Tolerance in seconds.}

\item{tr,other}{\code{TimeRange} objects.}
}
\value{
Logical.
}
\description{
Do two TimeRanges intersect?
}
\examples{
a <- TimeRange(RationalTime(0, 24), RationalTime(48, 24))
b <- TimeRange(RationalTime(24, 24), RationalTime(48, 24))
intersects(a, b)
}
