% tinyrox says don't edit this manually, but it can't stop you!
\name{in_offset}
\alias{in_offset}
\alias{in_offset<-}
\alias{out_offset}
\alias{out_offset<-}
\title{In and out offsets of a Transition}
\usage{
in_offset(x)

in_offset(x) <- value

out_offset(x)

out_offset(x) <- value
}
\arguments{
\item{x}{A \code{Transition}.}

\item{value}{A \code{RationalTime}.}
}
\value{
A \code{RationalTime}; the setter returns \code{x}.
}
\description{
In and out offsets of a Transition
}
