# Timeline accessors and the Track kind field.

#' Tracks (the Stack) of a Timeline
#' @param x A \code{Timeline}.
#' @param value A \code{Stack}.
#' @return The timeline's \code{Stack}; the setter returns \code{x}.
#' @export
tracks <- function(x) cpp_timeline_tracks(x)

#' @rdname tracks
#' @export
`tracks<-` <- function(x, value) {
    cpp_timeline_set_tracks(x, value)
    x
}

#' Global start time of a Timeline
#' @param x A \code{Timeline}.
#' @param value A \code{RationalTime} or \code{NULL}.
#' @return A \code{RationalTime} or \code{NULL}; the setter returns \code{x}.
#' @export
global_start_time <- function(x) cpp_timeline_global_start_time(x)

#' @rdname global_start_time
#' @export
`global_start_time<-` <- function(x, value) {
    cpp_timeline_set_global_start_time(x, value)
    x
}

#' Video and audio tracks of a Timeline
#' @param x A \code{Timeline}.
#' @return A list of \code{Track} objects of the matching kind.
#' @export
video_tracks <- function(x) cpp_timeline_video_tracks(x)

#' @rdname video_tracks
#' @export
audio_tracks <- function(x) cpp_timeline_audio_tracks(x)

#' Kind of a Track
#' @param x A \code{Track}.
#' @param value \code{"Video"} or \code{"Audio"}.
#' @return The kind string; the setter returns \code{x}.
#' @export
kind <- function(x) cpp_track_kind(x)

#' @rdname kind
#' @export
`kind<-` <- function(x, value) {
    cpp_track_set_kind(x, value)
    x
}
