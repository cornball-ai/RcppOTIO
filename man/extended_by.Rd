% tinyrox says don't edit this manually, but it can't stop you!
\name{extended_by}
\alias{extended_by}
\title{Extend a TimeRange to cover another}
\usage{
extended_by(tr, other)
}
\arguments{
\item{tr,other}{\code{TimeRange} objects.}
}
\value{
A \code{TimeRange}.
}
\description{
Extend a TimeRange to cover another
}
\examples{
a <- TimeRange(RationalTime(0, 24), RationalTime(24, 24))
b <- TimeRange(RationalTime(24, 24), RationalTime(24, 24))
extended_by(a, b)
}
