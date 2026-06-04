# Constructors for the OTIO schema classes. Names and defaults follow
# OTIO. Optional ranges/times default to NULL (std::optional nullopt);
# metadata defaults to an empty named list.

#' Timeline
#' @param name Object name.
#' @param global_start_time A \code{RationalTime} or \code{NULL}.
#' @param metadata Named list of metadata.
#' @return A \code{Timeline}.
#' @export
Timeline <- function(name = "", global_start_time = NULL, metadata = list()) {
    cpp_new_timeline(name, global_start_time, metadata)
}

#' Stack
#' @param name Object name.
#' @param source_range A \code{TimeRange} or \code{NULL}.
#' @param metadata Named list of metadata.
#' @return A \code{Stack}.
#' @export
Stack <- function(name = "", source_range = NULL, metadata = list()) {
    cpp_new_stack(name, source_range, metadata)
}

#' Track
#'
#' @param name Object name.
#' @param kind Track kind, \code{"Video"} or \code{"Audio"}.
#' @param source_range A \code{TimeRange} or \code{NULL}.
#' @param metadata Named list of metadata.
#' @return A \code{Track}.
#' @export
Track <- function(name = "", kind = "Video", source_range = NULL, metadata = list()) {
    cpp_new_track(name, source_range, kind, metadata)
}

#' Clip
#' @param name Object name.
#' @param media_reference A media reference object or \code{NULL}.
#' @param source_range A \code{TimeRange} or \code{NULL}.
#' @param metadata Named list of metadata.
#' @return A \code{Clip}.
#' @export
Clip <- function(name = "", media_reference = NULL, source_range = NULL, metadata = list()) {
    cpp_new_clip(name, media_reference, source_range, metadata)
}

#' Gap
#' @param duration A \code{RationalTime} giving the gap length.
#' @param name Object name.
#' @param metadata Named list of metadata.
#' @return A \code{Gap}.
#' @export
Gap <- function(duration, name = "", metadata = list()) {
    cpp_new_gap(duration, name, metadata)
}

#' Transition
#' @param name Object name.
#' @param transition_type Transition type string (e.g. \code{"SMPTE_Dissolve"}).
#' @param in_offset,out_offset \code{RationalTime} offsets into the
#'   neighbouring items.
#' @param metadata Named list of metadata.
#' @return A \code{Transition}.
#' @export
Transition <- function(name = "", transition_type = "",
                       in_offset = RationalTime(), out_offset = RationalTime(),
                       metadata = list()) {
    cpp_new_transition(name, transition_type, in_offset, out_offset, metadata)
}

#' Marker
#' @param name Object name.
#' @param marked_range A \code{TimeRange}.
#' @param color Marker color string (e.g. \code{"GREEN"}, \code{"RED"}).
#' @param comment Free-text comment.
#' @param metadata Named list of metadata.
#' @return A \code{Marker}.
#' @export
Marker <- function(name = "", marked_range = TimeRange(), color = "GREEN",
                   comment = "", metadata = list()) {
    cpp_new_marker(name, marked_range, color, metadata, comment)
}

#' Effect
#' @param name Object name.
#' @param effect_name Effect identifier string.
#' @param enabled Whether the effect is active.
#' @param metadata Named list of metadata.
#' @return An \code{Effect}.
#' @export
Effect <- function(name = "", effect_name = "", enabled = TRUE, metadata = list()) {
    cpp_new_effect(name, effect_name, metadata, enabled)
}

#' TimeEffect
#' @param name Object name.
#' @param effect_name Effect identifier string.
#' @param metadata Named list of metadata.
#' @return A \code{TimeEffect}.
#' @export
TimeEffect <- function(name = "", effect_name = "", metadata = list()) {
    cpp_new_time_effect(name, effect_name, metadata)
}

#' LinearTimeWarp
#' @param name Object name.
#' @param effect_name Effect identifier string.
#' @param time_scalar Playback rate multiplier (2 = double speed).
#' @param metadata Named list of metadata.
#' @return A \code{LinearTimeWarp}.
#' @export
LinearTimeWarp <- function(name = "", effect_name = "", time_scalar = 1, metadata = list()) {
    cpp_new_linear_time_warp(name, effect_name, time_scalar, metadata)
}

#' FreezeFrame
#' @param name Object name.
#' @param metadata Named list of metadata.
#' @return A \code{FreezeFrame}.
#' @export
FreezeFrame <- function(name = "", metadata = list()) {
    cpp_new_freeze_frame(name, metadata)
}

#' MediaReference
#' @param name Object name.
#' @param available_range A \code{TimeRange} or \code{NULL}.
#' @param metadata Named list of metadata.
#' @return A \code{MediaReference}.
#' @export
MediaReference <- function(name = "", available_range = NULL, metadata = list()) {
    cpp_new_media_reference(name, available_range, metadata)
}

#' ExternalReference
#' @param target_url URL or path to the media.
#' @param available_range A \code{TimeRange} or \code{NULL}.
#' @param metadata Named list of metadata.
#' @return An \code{ExternalReference}.
#' @export
ExternalReference <- function(target_url = "", available_range = NULL, metadata = list()) {
    cpp_new_external_reference(target_url, available_range, metadata)
}

#' ImageSequenceReference
#' @param target_url_base Base URL containing the frames.
#' @param name_prefix,name_suffix Filename prefix and suffix around the frame number.
#' @param start_frame,frame_step First frame number and step.
#' @param rate Frame rate.
#' @param frame_zero_padding Zero-padding width of the frame number.
#' @param missing_frame_policy 0 error, 1 hold, 2 black.
#' @param available_range A \code{TimeRange} or \code{NULL}.
#' @param metadata Named list of metadata.
#' @return An \code{ImageSequenceReference}.
#' @export
ImageSequenceReference <- function(target_url_base = "", name_prefix = "", name_suffix = "",
                                   start_frame = 1L, frame_step = 1L, rate = 1,
                                   frame_zero_padding = 0L, missing_frame_policy = 0L,
                                   available_range = NULL, metadata = list()) {
    cpp_new_image_sequence_reference(
        target_url_base, name_prefix, name_suffix,
        as.integer(start_frame), as.integer(frame_step), rate,
        as.integer(frame_zero_padding), as.integer(missing_frame_policy),
        available_range, metadata)
}

#' GeneratorReference
#' @param name Object name.
#' @param generator_kind Generator identifier (e.g. \code{"SMPTEBars"}).
#' @param available_range A \code{TimeRange} or \code{NULL}.
#' @param parameters Named list of generator parameters.
#' @param metadata Named list of metadata.
#' @return A \code{GeneratorReference}.
#' @export
GeneratorReference <- function(name = "", generator_kind = "", available_range = NULL,
                               parameters = list(), metadata = list()) {
    cpp_new_generator_reference(name, generator_kind, available_range, parameters, metadata)
}

#' MissingReference
#' @param name Object name.
#' @param available_range A \code{TimeRange} or \code{NULL}.
#' @param metadata Named list of metadata.
#' @return A \code{MissingReference}.
#' @export
MissingReference <- function(name = "", available_range = NULL, metadata = list()) {
    cpp_new_missing_reference(name, available_range, metadata)
}

#' SerializableCollection
#' @param name Object name.
#' @param children A list of OTIO objects.
#' @param metadata Named list of metadata.
#' @return A \code{SerializableCollection}.
#' @export
SerializableCollection <- function(name = "", children = list(), metadata = list()) {
    cpp_new_serializable_collection(name, children, metadata)
}
