% tinyrox says don't edit this manually, but it can't stop you!
\name{TimeTransform}
\alias{TimeTransform}
\title{TimeTransform}
\usage{
TimeTransform(offset = RationalTime(), scale = 1, rate = -1)
}
\arguments{
\item{offset}{A \code{RationalTime}.}

\item{scale}{Numeric scale factor.}

\item{rate}{Numeric rate (-1 leaves the rate unchanged).}
}
\value{
A \code{TimeTransform}.
}
\description{
An offset/scale/rate transform applied to times. Stored as a classed
list with elements \code{offset} (a \code{RationalTime}), \code{scale},
and \code{rate}.
}
