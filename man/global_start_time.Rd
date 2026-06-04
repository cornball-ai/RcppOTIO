% tinyrox says don't edit this manually, but it can't stop you!
\name{global_start_time}
\alias{global_start_time}
\alias{global_start_time<-}
\title{Global start time of a Timeline}
\usage{
global_start_time(x)

global_start_time(x) <- value
}
\arguments{
\item{x}{A \code{Timeline}.}

\item{value}{A \code{RationalTime} or \code{NULL}.}
}
\value{
A \code{RationalTime} or \code{NULL}; the setter returns \code{x}.
}
\description{
Global start time of a Timeline
}
\examples{
tl <- Timeline("demo")
global_start_time(tl) <- RationalTime(86400, 24)
global_start_time(tl)
}
