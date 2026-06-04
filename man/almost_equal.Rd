% tinyrox says don't edit this manually, but it can't stop you!
\name{almost_equal}
\alias{almost_equal}
\title{Approximate RationalTime equality}
\usage{
almost_equal(a, b, delta = 0)
}
\arguments{
\item{delta}{Tolerance in value units after rescaling.}

\item{a,b}{\code{RationalTime} objects.}
}
\value{
Logical.
}
\description{
Approximate RationalTime equality
}
\examples{
almost_equal(RationalTime(24, 24), RationalTime(24, 24))
}
