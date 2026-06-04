% tinyrox says don't edit this manually, but it can't stop you!
\name{schema_name}
\alias{schema_name}
\alias{schema_version}
\title{Schema name and version of an OTIO object}
\usage{
schema_name(x)

schema_version(x)
}
\arguments{
\item{x}{An OTIO object.}
}
\value{
The schema name (string) or version (integer).
}
\description{
Schema name and version of an OTIO object
}
\examples{
clip <- Clip("A")
schema_name(clip)
schema_version(clip)
}
