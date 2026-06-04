% tinyrox says don't edit this manually, but it can't stop you!
\name{Stack}
\alias{Stack}
\title{Stack}
\usage{
Stack(name = "", source_range = NULL, metadata = list())
}
\arguments{
\item{name}{Object name.}

\item{source_range}{A \code{TimeRange} or \code{NULL}.}

\item{metadata}{Named list of metadata.}
}
\value{
A \code{Stack}.
}
\description{
Stack
}
\examples{
st <- Stack("main stack")
st <- Stack("trimmed", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
}
