% tinyrox says don't edit this manually, but it can't stop you!
\name{RationalTime}
\alias{RationalTime}
\title{RationalTime}
\usage{
RationalTime(value = 0, rate = 1)
}
\arguments{
\item{value}{Numeric sample value (e.g. frame count).}

\item{rate}{Numeric sample rate (e.g. frames per second).}
}
\value{
A \code{RationalTime} object.
}
\description{
A time expressed as a value at a sample rate (e.g. a frame number at a
frame rate). Stored as a classed numeric vector with elements
\code{value} and \code{rate}.
}
