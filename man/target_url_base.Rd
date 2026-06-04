% tinyrox says don't edit this manually, but it can't stop you!
\name{target_url_base}
\alias{target_url_base}
\alias{target_url_base<-}
\title{Base URL of an ImageSequenceReference}
\usage{
target_url_base(x)

target_url_base(x) <- value
}
\arguments{
\item{x}{An \code{ImageSequenceReference}.}

\item{value}{A base URL string.}
}
\value{
The base URL; the setter returns \code{x}.
}
\description{
Base URL of an ImageSequenceReference
}
\examples{
isr <- ImageSequenceReference(
  target_url_base = "file:///seq/", name_prefix = "frame.",
  name_suffix = ".exr", start_frame = 1L, frame_step = 1L,
  rate = 24, frame_zero_padding = 4L,
  available_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
target_url_base(isr)
target_url_base(isr) <- "file:///other/"
}
