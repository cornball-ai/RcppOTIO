# Constructors for the OTIO schema classes. Names and defaults follow
# OTIO. Optional ranges/times default to NULL (std::optional nullopt);
# metadata defaults to an empty named list.

#' Timeline
#' @param name Object name.
#' @param global_start_time A \code{RationalTime} or \code{NULL}.
#' @param metadata Named list of metadata.
#' @return A \code{Timeline}.
#' @examples
#' tl <- Timeline("my timeline")
#' tl <- Timeline("with start", global_start_time = RationalTime(0, 24))
#' @export
Timeline <- function(name = "", global_start_time = NULL, metadata = list()) {
    cpp_new_timeline(name, global_start_time, metadata)
}

#' Stack
#' @param name Object name.
#' @param source_range A \code{TimeRange} or \code{NULL}.
#' @param metadata Named list of metadata.
#' @return A \code{Stack}.
#' @examples
#' st <- Stack("main stack")
#' st <- Stack("trimmed", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
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
#' @examples
#' trk <- Track("V1", kind = "Video")
#' aud <- Track("A1", kind = "Audio")
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
#' @examples
#' clip <- Clip("shot")
#' clip <- Clip("shot", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
#' @export
Clip <- function(name = "", media_reference = NULL, source_range = NULL, metadata = list()) {
    cpp_new_clip(name, media_reference, source_range, metadata)
}

#' Gap
#' @param duration A \code{RationalTime} giving the gap length.
#' @param name Object name.
#' @param metadata Named list of metadata.
#' @return A \code{Gap}.
#' @examples
#' g <- Gap(RationalTime(12, 24))
#' g <- Gap(RationalTime(24, 24), name = "black")
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
#' @examples
#' tr <- Transition("dissolve", transition_type = "SMPTE_Dissolve",
#'                  in_offset = RationalTime(6, 24), out_offset = RationalTime(6, 24))
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
#' @examples
#' m <- Marker("look here",
#'             marked_range = TimeRange(RationalTime(0, 24), RationalTime(1, 24)),
#'             color = "RED")
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
#' @examples
#' ef <- Effect("blur", effect_name = "GaussianBlur")
#' ef <- Effect("blur", effect_name = "GaussianBlur", enabled = FALSE)
#' @export
Effect <- function(name = "", effect_name = "", enabled = TRUE, metadata = list()) {
    cpp_new_effect(name, effect_name, metadata, enabled)
}

#' TimeEffect
#' @param name Object name.
#' @param effect_name Effect identifier string.
#' @param metadata Named list of metadata.
#' @return A \code{TimeEffect}.
#' @examples
#' te <- TimeEffect("retime", effect_name = "Retime")
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
#' @examples
#' ltw <- LinearTimeWarp("half speed", time_scalar = 0.5)
#' ltw <- LinearTimeWarp("double speed", time_scalar = 2)
#' @export
LinearTimeWarp <- function(name = "", effect_name = "", time_scalar = 1, metadata = list()) {
    cpp_new_linear_time_warp(name, effect_name, time_scalar, metadata)
}

#' FreezeFrame
#' @param name Object name.
#' @param metadata Named list of metadata.
#' @return A \code{FreezeFrame}.
#' @examples
#' ff <- FreezeFrame("hold")
#' @export
FreezeFrame <- function(name = "", metadata = list()) {
    cpp_new_freeze_frame(name, metadata)
}

#' MediaReference
#' @param name Object name.
#' @param available_range A \code{TimeRange} or \code{NULL}.
#' @param metadata Named list of metadata.
#' @return A \code{MediaReference}.
#' @examples
#' mr <- MediaReference("ref")
#' mr <- MediaReference("ref",
#'                      available_range = TimeRange(RationalTime(0, 24), RationalTime(240, 24)))
#' @export
MediaReference <- function(name = "", available_range = NULL, metadata = list()) {
    cpp_new_media_reference(name, available_range, metadata)
}

#' ExternalReference
#' @param target_url URL or path to the media.
#' @param available_range A \code{TimeRange} or \code{NULL}.
#' @param metadata Named list of metadata.
#' @return An \code{ExternalReference}.
#' @examples
#' er <- ExternalReference("shot.mov")
#' er <- ExternalReference("shot.mov",
#'                         available_range = TimeRange(RationalTime(0, 24), RationalTime(240, 24)))
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
#' @examples
#' isr <- ImageSequenceReference(
#'     target_url_base = "file:///renders/", name_prefix = "frame.",
#'     name_suffix = ".exr", start_frame = 1L, rate = 24,
#'     frame_zero_padding = 4L)
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
#' @examples
#' gr <- GeneratorReference("bars", generator_kind = "SMPTEBars")
#' gr <- GeneratorReference("bars", generator_kind = "SMPTEBars",
#'                          available_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
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
#' @examples
#' mr <- MissingReference("offline")
#' @export
MissingReference <- function(name = "", available_range = NULL, metadata = list()) {
    cpp_new_missing_reference(name, available_range, metadata)
}

#' SerializableCollection
#' @param name Object name.
#' @param children A list of OTIO objects.
#' @param metadata Named list of metadata.
#' @return A \code{SerializableCollection}.
#' @examples
#' sc <- SerializableCollection("bin", children = list(Clip("a"), Clip("b")))
#' @export
SerializableCollection <- function(name = "", children = list(), metadata = list()) {
    cpp_new_serializable_collection(name, children, metadata)
}
