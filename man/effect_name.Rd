% tinyrox says don't edit this manually, but it can't stop you!
\name{effect_name}
\alias{effect_name}
\alias{effect_name<-}
\title{Effect name (the effect identifier, distinct from object name)}
\usage{
effect_name(x)

effect_name(x) <- value
}
\arguments{
\item{x}{An \code{Effect}.}

\item{value}{An effect identifier string.}
}
\value{
The effect name; the setter returns \code{x}.
}
\description{
Effect name (the effect identifier, distinct from object name)
}
\examples{
ef <- Effect("blur", effect_name = "GaussianBlur")
effect_name(ef)
}
