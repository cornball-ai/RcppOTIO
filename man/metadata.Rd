% tinyrox says don't edit this manually, but it can't stop you!
\name{metadata}
\alias{metadata}
\alias{metadata<-}
\title{Metadata dictionary of an OTIO object}
\usage{
metadata(x)

metadata(x) <- value
}
\arguments{
\item{x}{An OTIO object (with metadata).}

\item{value}{A named list.}
}
\value{
The metadata list; the setter returns \code{x}.
}
\description{
Metadata is a named list. Supported value types are logical, integer,
double, and character scalars/vectors, the OTIO time types, nested
named lists (sub-dictionaries), unnamed lists (vectors), and OTIO
objects. Other value types are dropped with a warning on read.
}
