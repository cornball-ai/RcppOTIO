% tinyrox says don't edit this manually, but it can't stop you!
\name{video_tracks}
\alias{video_tracks}
\alias{audio_tracks}
\title{Video and audio tracks of a Timeline}
\usage{
video_tracks(x)

audio_tracks(x)
}
\arguments{
\item{x}{A \code{Timeline}.}
}
\value{
A list of \code{Track} objects of the matching kind.
}
\description{
Video and audio tracks of a Timeline
}
\examples{
tl <- Timeline("demo")
append_child(tracks(tl), Track("V1", kind = "Video"))
length(video_tracks(tl))
length(audio_tracks(tl))
}
