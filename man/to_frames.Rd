% tinyrox says don't edit this manually, but it can't stop you!
\name{to_frames}
\alias{to_frames}
\title{Convert a RationalTime to a frame number}
\usage{
to_frames(rt)
}
\arguments{
\item{rt}{A \code{RationalTime}.}
}
\value{
Integer frame number at the time's own rate.
}
\description{
Convert a RationalTime to a frame number
}
\examples{
to_frames(RationalTime(48, 24))
}
