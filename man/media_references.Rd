% tinyrox says don't edit this manually, but it can't stop you!
\name{media_references}
\alias{media_references}
\title{All media references of a Clip, keyed by media key}
\usage{
media_references(x)
}
\arguments{
\item{x}{A \code{Clip}.}
}
\value{
A named list mapping media keys to media-reference objects.
}
\description{
A clip can hold several media references (e.g. proxy and full-res) under
string keys, one of which is the \code{active_media_reference_key}.
}
\examples{
clip <- Clip("c", media_reference = ExternalReference("a.mov"))
media_references(clip)
}
