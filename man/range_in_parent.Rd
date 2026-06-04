% tinyrox says don't edit this manually, but it can't stop you!
\name{range_in_parent}
\alias{range_in_parent}
\title{Range of an Item within its parent}
\usage{
range_in_parent(x)
}
\arguments{
\item{x}{An \code{Item} or \code{Transition}.}
}
\value{
A \code{TimeRange}. For a \code{Transition} this is
  \code{NULL} when it has no parent (an \code{Item} always has a range).
}
\description{
This is where the item sits in its parent's time, the OTIO notion of
timeline position. There is no separately stored "in" point.
}
