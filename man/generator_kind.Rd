% tinyrox says don't edit this manually, but it can't stop you!
\name{generator_kind}
\alias{generator_kind}
\alias{generator_kind<-}
\title{Generator kind of a GeneratorReference}
\usage{
generator_kind(x)

generator_kind(x) <- value
}
\arguments{
\item{x}{A \code{GeneratorReference}.}

\item{value}{A generator identifier string.}
}
\value{
The generator kind; the setter returns \code{x}.
}
\description{
Generator kind of a GeneratorReference
}
\examples{
gen <- GeneratorReference("bars", generator_kind = "SMPTEBars")
generator_kind(gen)
}
