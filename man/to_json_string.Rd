% tinyrox says don't edit this manually, but it can't stop you!
\name{to_json_string}
\alias{to_json_string}
\title{Serialize an OTIO object to a JSON string}
\usage{
to_json_string(x, indent = 4L, target_schema_versions = NULL)
}
\arguments{
\item{x}{An OTIO object.}

\item{indent}{Indentation width (spaces).}

\item{target_schema_versions}{Optional named integer vector mapping
schema names to target versions (e.g. \code{c(Clip = 1L)}). When
supplied, OTIO downgrades each object to the requested version using
the registered downgrade functions.}
}
\value{
A JSON string in OTIO's vocabulary.
}
\description{
Serialize an OTIO object to a JSON string
}
\examples{
tl <- Timeline("demo")
js <- to_json_string(tl)
nchar(js) > 0
}
