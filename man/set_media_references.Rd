% tinyrox says don't edit this manually, but it can't stop you!
\name{set_media_references}
\alias{set_media_references}
\title{Set all media references of a Clip}
\usage{
set_media_references(x, media_references, new_active_key)
}
\arguments{
\item{x}{A \code{Clip}.}

\item{media_references}{A named list mapping non-empty keys to media
references.}

\item{new_active_key}{The key to make active (must exist in
\code{media_references}).}
}
\value{
\code{x}, invisibly.
}
\description{
Replaces the clip's media-reference map and chooses the active key.
OTIO requires \code{new_active_key} to be one of the map's keys and
rejects empty keys.
}
