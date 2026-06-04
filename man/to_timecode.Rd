% tinyrox says don't edit this manually, but it can't stop you!
\name{to_timecode}
\alias{to_timecode}
\alias{from_timecode}
\title{SMPTE timecode conversions}
\usage{
to_timecode(rt, rate, drop_frame = -1L)

from_timecode(timecode, rate)
}
\arguments{
\item{rt}{A \code{RationalTime}.}

\item{rate}{Timecode rate.}

\item{drop_frame}{-1 infer, 0 force non-drop, 1 force drop-frame.}

\item{timecode}{A SMPTE timecode string.}
}
\value{
A timecode string.
}
\description{
SMPTE timecode conversions
}
\examples{
tc <- to_timecode(RationalTime(48, 24), 24)
tc
from_timecode(tc, 24)
}
