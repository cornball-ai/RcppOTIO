% tinyrox says don't edit this manually, but it can't stop you!
\name{comment}
\alias{comment}
\alias{comment<-}
\title{Comment on a Marker}
\usage{
comment(x)

comment(x) <- value
}
\arguments{
\item{x}{A \code{Marker}.}

\item{value}{A comment string.}
}
\value{
The comment; the setter returns \code{x}.
}
\description{
Comment on a Marker
}
\examples{
m <- Marker("m", marked_range = TimeRange(RationalTime(0, 24), RationalTime(1, 24)),
  color = "RED")
comment(m) <- "note"
comment(m)
}
