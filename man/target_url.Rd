% tinyrox says don't edit this manually, but it can't stop you!
\name{target_url}
\alias{target_url}
\alias{target_url<-}
\title{Target URL of an ExternalReference}
\usage{
target_url(x)

target_url(x) <- value
}
\arguments{
\item{x}{An \code{ExternalReference}.}

\item{value}{A URL or path string.}
}
\value{
The target URL; the setter returns \code{x}.
}
\description{
Target URL of an ExternalReference
}
\examples{
er <- ExternalReference("a.mov")
target_url(er)
target_url(er) <- "b.mov"
}
