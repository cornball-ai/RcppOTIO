% tinyrox says don't edit this manually, but it can't stop you!
\name{presentation_time_for_image_number}
\alias{presentation_time_for_image_number}
\title{Presentation time for a given image number in a sequence}
\usage{
presentation_time_for_image_number(x, image_number)
}
\arguments{
\item{x}{An \code{ImageSequenceReference}.}

\item{image_number}{1-based image number within the sequence.}
}
\value{
A \code{RationalTime}.
}
\description{
Presentation time for a given image number in a sequence
}
\examples{
isr <- ImageSequenceReference(
  target_url_base = "file:///seq/", name_prefix = "frame.",
  name_suffix = ".exr", start_frame = 1L, frame_step = 1L,
  rate = 24, frame_zero_padding = 4L,
  available_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
presentation_time_for_image_number(isr, 1L)
}
