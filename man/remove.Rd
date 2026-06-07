% tinyrox says don't edit this manually, but it can't stop you!
\name{remove}
\alias{remove}
\title{Remove the item at a time, optionally leaving a gap}
\usage{
remove(composition, time, fill = TRUE, fill_template = NULL)
}
\arguments{
\item{composition}{The \code{Composition} to remove from.}

\item{time}{The \code{RationalTime} locating the item to remove.}

\item{fill}{If \code{TRUE} (default) leave a gap (or \code{fill_template});
if \code{FALSE} concatenate the neighbours.}

\item{fill_template}{Optional \code{Item} to fill with; \code{NULL} uses a gap.}
}
\value{
\code{composition}, invisibly.
}
\description{
Masks \code{base::remove}; use \code{RcppOTIO::remove} / \code{base::remove}
to disambiguate.
}
\examples{
library(RcppOTIO)
trk <- Track("V1", kind = "Video")
append_child(trk, Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
append_child(trk, Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
RcppOTIO::remove(trk, RationalTime(60, 24))
}
