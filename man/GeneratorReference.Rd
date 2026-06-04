% tinyrox says don't edit this manually, but it can't stop you!
\name{GeneratorReference}
\alias{GeneratorReference}
\title{GeneratorReference}
\usage{
GeneratorReference(name = "", generator_kind = "", available_range = NULL,
                   parameters = list(), metadata = list())
}
\arguments{
\item{name}{Object name.}

\item{generator_kind}{Generator identifier (e.g. \code{"SMPTEBars"}).}

\item{available_range}{A \code{TimeRange} or \code{NULL}.}

\item{parameters}{Named list of generator parameters.}

\item{metadata}{Named list of metadata.}
}
\value{
A \code{GeneratorReference}.
}
\description{
GeneratorReference
}
