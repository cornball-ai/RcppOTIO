% tinyrox says don't edit this manually, but it can't stop you!
\name{Ops.RationalTime}
\alias{Ops.RationalTime}
\title{Arithmetic and comparison on RationalTime}
\usage{
\method{Ops}{RationalTime}(e1, e2)
}
\arguments{
\item{e1,e2}{\code{RationalTime} objects.}
}
\value{
A \code{RationalTime} for \code{+}/\code{-}, otherwise logical.
}
\description{
\code{RationalTime} supports \code{+} and \code{-} (returning a
\code{RationalTime}) and the comparison operators (returning a logical).
}
\examples{
RationalTime(10, 24) + RationalTime(5, 24)
RationalTime(10, 24) < RationalTime(20, 24)
}
