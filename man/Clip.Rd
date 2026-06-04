% tinyrox says don't edit this manually, but it can't stop you!
\name{Clip}
\alias{Clip}
\title{Clip}
\usage{
Clip(name = "", media_reference = NULL, source_range = NULL, metadata = list())
}
\arguments{
\item{name}{Object name.}

\item{media_reference}{A media reference object or \code{NULL}.}

\item{source_range}{A \code{TimeRange} or \code{NULL}.}

\item{metadata}{Named list of metadata.}
}
\value{
A \code{Clip}.
}
\description{
Clip
}
\examples{
clip <- Clip("shot")
clip <- Clip("shot", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
}
