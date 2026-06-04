% tinyrox says don't edit this manually, but it can't stop you!
\name{value}
\alias{value}
\alias{rate}
\title{Value and rate accessors}
\usage{
value(x)

rate(x)
}
\arguments{
\item{x}{A \code{RationalTime}, \code{TimeTransform}, or other OTIO
object carrying a \code{value} or \code{rate} field.}
}
\value{
A numeric scalar.
}
\description{
Value and rate accessors
}
\examples{
value(RationalTime(48, 24))
rate(RationalTime(48, 24))
}
