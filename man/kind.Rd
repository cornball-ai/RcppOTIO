% tinyrox says don't edit this manually, but it can't stop you!
\name{kind}
\alias{kind}
\alias{kind<-}
\title{Kind of a Track}
\usage{
kind(x)

kind(x) <- value
}
\arguments{
\item{x}{A \code{Track}.}

\item{value}{\code{"Video"} or \code{"Audio"}.}
}
\value{
The kind string; the setter returns \code{x}.
}
\description{
Kind of a Track
}
\examples{
trk <- Track("V1", kind = "Video")
kind(trk)
kind(trk) <- "Audio"
kind(trk)
}
