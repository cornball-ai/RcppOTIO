% tinyrox says don't edit this manually, but it can't stop you!
\name{name_prefix}
\alias{name_prefix}
\alias{name_suffix}
\alias{start_frame}
\alias{frame_step}
\alias{frame_zero_padding}
\alias{end_frame}
\alias{number_of_images_in_sequence}
\title{Image sequence frame fields}
\usage{
name_prefix(x)

name_suffix(x)

start_frame(x)

frame_step(x)

frame_zero_padding(x)

end_frame(x)

number_of_images_in_sequence(x)
}
\arguments{
\item{x}{An \code{ImageSequenceReference}.}
}
\value{
The named field value.
}
\description{
Image sequence frame fields
}
\examples{
isr <- ImageSequenceReference(
  target_url_base = "file:///seq/", name_prefix = "frame.",
  name_suffix = ".exr", start_frame = 1L, frame_step = 1L,
  rate = 24, frame_zero_padding = 4L,
  available_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
name_prefix(isr)
name_suffix(isr)
start_frame(isr)
frame_step(isr)
frame_zero_padding(isr)
end_frame(isr)
number_of_images_in_sequence(isr)
}
