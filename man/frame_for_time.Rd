% tinyrox says don't edit this manually, but it can't stop you!
\name{frame_for_time}
\alias{frame_for_time}
\title{Frame number covering a time in an image sequence}
\usage{
frame_for_time(x, time)
}
\arguments{
\item{x}{An \code{ImageSequenceReference}.}

\item{time}{A \code{RationalTime}.}
}
\value{
Integer frame number.
}
\description{
Frame number covering a time in an image sequence
}
\examples{
isr <- ImageSequenceReference(
  target_url_base = "file:///seq/", name_prefix = "frame.",
  name_suffix = ".exr", start_frame = 1L, frame_step = 1L,
  rate = 24, frame_zero_padding = 4L,
  available_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
frame_for_time(isr, RationalTime(0, 24))
}
