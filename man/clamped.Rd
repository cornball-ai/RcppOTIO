% tinyrox says don't edit this manually, but it can't stop you!
\name{clamped}
\alias{clamped}
\title{Clamp one TimeRange to another}
\usage{
clamped(tr, other)
}
\arguments{
\item{tr,other}{\code{TimeRange} objects.}
}
\value{
A \code{TimeRange}.
}
\description{
Clamp one TimeRange to another
}
\examples{
bounds <- TimeRange(RationalTime(0, 24), RationalTime(48, 24))
wide   <- TimeRange(RationalTime(-12, 24), RationalTime(96, 24))
clamped(bounds, wide)
}
