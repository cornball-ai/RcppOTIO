% tinyrox says don't edit this manually, but it can't stop you!
\name{Transition}
\alias{Transition}
\title{Transition}
\usage{
Transition(name = "", transition_type = "", in_offset = RationalTime(),
           out_offset = RationalTime(), metadata = list())
}
\arguments{
\item{name}{Object name.}

\item{transition_type}{Transition type string (e.g. \code{"SMPTE_Dissolve"}).}

\item{metadata}{Named list of metadata.}

\item{in_offset,out_offset}{\code{RationalTime} offsets into the
neighbouring items.}
}
\value{
A \code{Transition}.
}
\description{
Transition
}
