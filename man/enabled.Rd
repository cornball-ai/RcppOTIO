% tinyrox says don't edit this manually, but it can't stop you!
\name{enabled}
\alias{enabled}
\alias{enabled<-}
\title{Whether an Item or Effect is enabled}
\usage{
enabled(x)

enabled(x) <- value
}
\arguments{
\item{x}{An \code{Item} or \code{Effect}.}

\item{value}{Logical.}
}
\value{
Logical; the setter returns \code{x}.
}
\description{
Whether an Item or Effect is enabled
}
\examples{
library(RcppOTIO)
clip <- Clip("A")
enabled(clip)
enabled(clip) <- FALSE
}
