% tinyrox says don't edit this manually, but it can't stop you!
\name{transition_type}
\alias{transition_type}
\alias{transition_type<-}
\title{Transition type}
\usage{
transition_type(x)

transition_type(x) <- value
}
\arguments{
\item{x}{A \code{Transition}.}

\item{value}{A transition type string.}
}
\value{
The transition type; the setter returns \code{x}.
}
\description{
Transition type
}
\examples{
tx <- Transition("d", transition_type = "SMPTE_Dissolve",
  in_offset = RationalTime(6, 24), out_offset = RationalTime(6, 24))
transition_type(tx)
}
