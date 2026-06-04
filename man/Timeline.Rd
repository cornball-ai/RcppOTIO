% tinyrox says don't edit this manually, but it can't stop you!
\name{Timeline}
\alias{Timeline}
\title{Timeline}
\usage{
Timeline(name = "", global_start_time = NULL, metadata = list())
}
\arguments{
\item{name}{Object name.}

\item{global_start_time}{A \code{RationalTime} or \code{NULL}.}

\item{metadata}{Named list of metadata.}
}
\value{
A \code{Timeline}.
}
\description{
Timeline
}
\examples{
tl <- Timeline("my timeline")
tl <- Timeline("with start", global_start_time = RationalTime(0, 24))
}
