% tinyrox says don't edit this manually, but it can't stop you!
\name{Track}
\alias{Track}
\title{Track}
\usage{
Track(name = "", kind = "Video", source_range = NULL, metadata = list())
}
\arguments{
\item{name}{Object name.}

\item{kind}{Track kind, \code{"Video"} or \code{"Audio"}.}

\item{source_range}{A \code{TimeRange} or \code{NULL}.}

\item{metadata}{Named list of metadata.}
}
\value{
A \code{Track}.
}
\description{
Track
}
\examples{
trk <- Track("V1", kind = "Video")
aud <- Track("A1", kind = "Audio")
}
