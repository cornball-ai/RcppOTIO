% tinyrox says don't edit this manually, but it can't stop you!
\name{tracks}
\alias{tracks}
\alias{tracks<-}
\title{Tracks (the Stack) of a Timeline}
\usage{
tracks(x)

tracks(x) <- value
}
\arguments{
\item{x}{A \code{Timeline}.}

\item{value}{A \code{Stack}.}
}
\value{
The timeline's \code{Stack}; the setter returns \code{x}.
}
\description{
Tracks (the Stack) of a Timeline
}
\examples{
tl <- Timeline("demo")
trk <- Track("V1", kind = "Video")
append_child(tracks(tl), trk)
length(children(tracks(tl)))
}
