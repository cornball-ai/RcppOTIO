% tinyrox says don't edit this manually, but it can't stop you!
\name{fill}
\alias{fill}
\title{Fill an item into a track at a time (3/4-point edit)}
\usage{
fill(item, track, track_time, reference_point = "Source")
}
\arguments{
\item{item}{The \code{Item} to place (usually a \code{Clip}).}

\item{track}{The \code{Composition} that will own the item.}

\item{track_time}{The \code{RationalTime} to place it at.}

\item{reference_point}{One of \code{"Source"}, \code{"Sequence"}, or
\code{"Fit"}, controlling the transform for 4-point editing.}
}
\value{
\code{track}, invisibly.
}
\description{
Fill an item into a track at a time (3/4-point edit)
}
