% tinyrox says don't edit this manually, but it can't stop you!
\name{ImageSequenceReference}
\alias{ImageSequenceReference}
\title{ImageSequenceReference}
\usage{
ImageSequenceReference(target_url_base = "", name_prefix = "",
                       name_suffix = "", start_frame = 1L, frame_step = 1L,
                       rate = 1, frame_zero_padding = 0L,
                       missing_frame_policy = 0L, available_range = NULL,
                       metadata = list())
}
\arguments{
\item{target_url_base}{Base URL containing the frames.}

\item{rate}{Frame rate.}

\item{frame_zero_padding}{Zero-padding width of the frame number.}

\item{missing_frame_policy}{0 error, 1 hold, 2 black.}

\item{available_range}{A \code{TimeRange} or \code{NULL}.}

\item{metadata}{Named list of metadata.}

\item{name_prefix,name_suffix}{Filename prefix and suffix around the frame number.}

\item{start_frame,frame_step}{First frame number and step.}
}
\value{
An \code{ImageSequenceReference}.
}
\description{
ImageSequenceReference
}
