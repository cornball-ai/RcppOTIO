% tinyrox says don't edit this manually, but it can't stop you!
\name{name}
\alias{name}
\alias{name<-}
\title{Name of an OTIO object}
\usage{
name(x)

name(x) <- value
}
\arguments{
\item{x}{An OTIO object (with metadata).}

\item{value}{New name.}
}
\value{
The name string; the setter returns \code{x}.
}
\description{
\code{name} is descriptive metadata, not identity: siblings may share a
name. Address tree children by position and reference instead.
}
\examples{
clip <- Clip("A")
name(clip)
name(clip) <- "B"
name(clip)
}
