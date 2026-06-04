% tinyrox says don't edit this manually, but it can't stop you!
\name{clone}
\alias{clone}
\title{Deep-clone an OTIO object}
\usage{
clone(x)
}
\arguments{
\item{x}{An OTIO object.}
}
\value{
An independent copy.
}
\description{
Deep-clone an OTIO object
}
\examples{
clip <- Clip("orig")
clip2 <- clone(clip)
name(clip2) <- "copy"
name(clip)   # still "orig"
}
