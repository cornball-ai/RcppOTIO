% tinyrox says don't edit this manually, but it can't stop you!
\name{insert}
\alias{insert}
\title{Insert an item at a time, splitting whatever is there}
\usage{
insert(item, composition, time, remove_transitions = TRUE, fill_template = NULL)
}
\arguments{
\item{item}{The \code{Item} to insert (usually a \code{Clip}).}

\item{composition}{The target \code{Composition} (usually a \code{Track}).}

\item{time}{The \code{RationalTime} to insert at. Before the start inserts
at index 0; past the end appends.}

\item{remove_transitions}{Whether to drop transitions intersecting \code{time}.}

\item{fill_template}{Optional \code{Item} to fill any gap when \code{time}
is past the composition's end; \code{NULL} uses OTIO's default.}
}
\value{
\code{composition}, invisibly.
}
\description{
Insert an item at a time, splitting whatever is there
}
