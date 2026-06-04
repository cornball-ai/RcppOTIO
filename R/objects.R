# Field accessors for Clip, the media references, Transition, Marker,
# Effect, and LinearTimeWarp. Names mirror OTIO exactly.

# ---- Clip ------------------------------------------------------------

#' Active media reference of a Clip
#' @param x A \code{Clip}.
#' @param value A media reference object or \code{NULL}.
#' @return The active media reference (or \code{NULL}); the setter returns \code{x}.
#' @examples
#' clip <- Clip("c", media_reference = ExternalReference("a.mov"))
#' media_reference(clip)
#' media_reference(clip) <- ExternalReference("b.mov")
#' @export
media_reference <- function(x) cpp_clip_media_reference(x)

#' @rdname media_reference
#' @export
`media_reference<-` <- function(x, value) {
    cpp_clip_set_media_reference(x, value)
    x
}

#' Active media reference key of a Clip
#' @param x A \code{Clip}.
#' @param value The key to make active (must exist).
#' @return The active key string; the setter returns \code{x}.
#' @examples
#' clip <- Clip("c", media_reference = ExternalReference("a.mov"))
#' active_media_reference_key(clip)
#' @export
active_media_reference_key <- function(x) cpp_clip_active_media_reference_key(x)

#' @rdname active_media_reference_key
#' @export
`active_media_reference_key<-` <- function(x, value) {
    cpp_clip_set_active_media_reference_key(x, value)
    x
}

#' The default media reference key
#' @return The string OTIO uses for a clip's default media (\code{"DEFAULT_MEDIA"}).
#' @examples
#' default_media_key()
#' @export
default_media_key <- function() cpp_clip_default_media_key()

#' All media references of a Clip, keyed by media key
#'
#' A clip can hold several media references (e.g. proxy and full-res) under
#' string keys, one of which is the \code{active_media_reference_key}.
#'
#' @param x A \code{Clip}.
#' @return A named list mapping media keys to media-reference objects.
#' @examples
#' clip <- Clip("c", media_reference = ExternalReference("a.mov"))
#' media_references(clip)
#' @export
media_references <- function(x) cpp_clip_media_references(x)

#' Set all media references of a Clip
#'
#' Replaces the clip's media-reference map and chooses the active key.
#' OTIO requires \code{new_active_key} to be one of the map's keys and
#' rejects empty keys.
#'
#' @param x A \code{Clip}.
#' @param media_references A named list mapping non-empty keys to media
#'   references.
#' @param new_active_key The key to make active (must exist in
#'   \code{media_references}).
#' @return \code{x}, invisibly.
#' @examples
#' clip <- Clip("c", media_reference = ExternalReference("a.mov"))
#' set_media_references(clip,
#'   list(proxy = ExternalReference("p.mov"), full = ExternalReference("f.mov")),
#'   new_active_key = "full")
#' @export
set_media_references <- function(x, media_references, new_active_key) {
    cpp_clip_set_media_references(x, media_references, new_active_key)
    invisible(x)
}

# ---- MediaReference subtypes -----------------------------------------

#' Is this a MissingReference?
#' @param x A \code{MediaReference}.
#' @return Logical.
#' @examples
#' is_missing_reference(MissingReference("x"))
#' is_missing_reference(ExternalReference("a.mov"))
#' @export
is_missing_reference <- function(x) cpp_mediaref_is_missing_reference(x)

#' Target URL of an ExternalReference
#' @param x An \code{ExternalReference}.
#' @param value A URL or path string.
#' @return The target URL; the setter returns \code{x}.
#' @examples
#' er <- ExternalReference("a.mov")
#' target_url(er)
#' target_url(er) <- "b.mov"
#' @export
target_url <- function(x) cpp_extref_target_url(x)

#' @rdname target_url
#' @export
`target_url<-` <- function(x, value) {
    cpp_extref_set_target_url(x, value)
    x
}

#' Base URL of an ImageSequenceReference
#' @param x An \code{ImageSequenceReference}.
#' @param value A base URL string.
#' @return The base URL; the setter returns \code{x}.
#' @examples
#' isr <- ImageSequenceReference(
#'   target_url_base = "file:///seq/", name_prefix = "frame.",
#'   name_suffix = ".exr", start_frame = 1L, frame_step = 1L,
#'   rate = 24, frame_zero_padding = 4L,
#'   available_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
#' target_url_base(isr)
#' target_url_base(isr) <- "file:///other/"
#' @export
target_url_base <- function(x) cpp_imgseq_target_url_base(x)

#' @rdname target_url_base
#' @export
`target_url_base<-` <- function(x, value) {
    cpp_imgseq_set_target_url_base(x, value)
    x
}

#' Image sequence frame fields
#' @param x An \code{ImageSequenceReference}.
#' @return The named field value.
#' @examples
#' isr <- ImageSequenceReference(
#'   target_url_base = "file:///seq/", name_prefix = "frame.",
#'   name_suffix = ".exr", start_frame = 1L, frame_step = 1L,
#'   rate = 24, frame_zero_padding = 4L,
#'   available_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
#' name_prefix(isr)
#' name_suffix(isr)
#' start_frame(isr)
#' frame_step(isr)
#' frame_zero_padding(isr)
#' end_frame(isr)
#' number_of_images_in_sequence(isr)
#' @export
name_prefix <- function(x) cpp_imgseq_name_prefix(x)

#' @rdname name_prefix
#' @export
name_suffix <- function(x) cpp_imgseq_name_suffix(x)

#' @rdname name_prefix
#' @export
start_frame <- function(x) cpp_imgseq_start_frame(x)

#' @rdname name_prefix
#' @export
frame_step <- function(x) cpp_imgseq_frame_step(x)

#' @rdname name_prefix
#' @export
frame_zero_padding <- function(x) cpp_imgseq_frame_zero_padding(x)

#' @rdname name_prefix
#' @export
end_frame <- function(x) cpp_imgseq_end_frame(x)

#' @rdname name_prefix
#' @export
number_of_images_in_sequence <- function(x) cpp_imgseq_number_of_images_in_sequence(x)

#' @export
rate.ImageSequenceReference <- function(x) cpp_imgseq_rate(x)

#' Frame number covering a time in an image sequence
#' @param x An \code{ImageSequenceReference}.
#' @param time A \code{RationalTime}.
#' @return Integer frame number.
#' @examples
#' isr <- ImageSequenceReference(
#'   target_url_base = "file:///seq/", name_prefix = "frame.",
#'   name_suffix = ".exr", start_frame = 1L, frame_step = 1L,
#'   rate = 24, frame_zero_padding = 4L,
#'   available_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
#' frame_for_time(isr, RationalTime(0, 24))
#' @export
frame_for_time <- function(x, time) cpp_imgseq_frame_for_time(x, time)

#' Target URL for a given image number in a sequence
#' @param x An \code{ImageSequenceReference}.
#' @param image_number 1-based image number within the sequence.
#' @return A URL string.
#' @examples
#' isr <- ImageSequenceReference(
#'   target_url_base = "file:///seq/", name_prefix = "frame.",
#'   name_suffix = ".exr", start_frame = 1L, frame_step = 1L,
#'   rate = 24, frame_zero_padding = 4L,
#'   available_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
#' target_url_for_image_number(isr, 1L)
#' @export
target_url_for_image_number <- function(x, image_number) {
    cpp_imgseq_target_url_for_image_number(x, .to_otio_index(image_number))
}

#' Presentation time for a given image number in a sequence
#' @param x An \code{ImageSequenceReference}.
#' @param image_number 1-based image number within the sequence.
#' @return A \code{RationalTime}.
#' @examples
#' isr <- ImageSequenceReference(
#'   target_url_base = "file:///seq/", name_prefix = "frame.",
#'   name_suffix = ".exr", start_frame = 1L, frame_step = 1L,
#'   rate = 24, frame_zero_padding = 4L,
#'   available_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
#' presentation_time_for_image_number(isr, 1L)
#' @export
presentation_time_for_image_number <- function(x, image_number) {
    cpp_imgseq_presentation_time_for_image_number(x, .to_otio_index(image_number))
}

#' Generator kind of a GeneratorReference
#' @param x A \code{GeneratorReference}.
#' @param value A generator identifier string.
#' @return The generator kind; the setter returns \code{x}.
#' @examples
#' gen <- GeneratorReference("bars", generator_kind = "SMPTEBars")
#' generator_kind(gen)
#' @export
generator_kind <- function(x) cpp_genref_generator_kind(x)

#' @rdname generator_kind
#' @export
`generator_kind<-` <- function(x, value) {
    cpp_genref_set_generator_kind(x, value)
    x
}

#' Parameters of a GeneratorReference
#' @param x A \code{GeneratorReference}.
#' @param value A named list of parameters.
#' @return The parameters list; the setter returns \code{x}.
#' @examples
#' gen <- GeneratorReference("bars", generator_kind = "SMPTEBars")
#' parameters(gen) <- list(width = 1920)
#' parameters(gen)
#' @export
parameters <- function(x) cpp_genref_parameters(x)

#' @rdname parameters
#' @export
`parameters<-` <- function(x, value) {
    cpp_genref_set_parameters(x, value)
    x
}

# ---- Transition ------------------------------------------------------

#' Transition type
#' @param x A \code{Transition}.
#' @param value A transition type string.
#' @return The transition type; the setter returns \code{x}.
#' @examples
#' tx <- Transition("d", transition_type = "SMPTE_Dissolve",
#'   in_offset = RationalTime(6, 24), out_offset = RationalTime(6, 24))
#' transition_type(tx)
#' @export
transition_type <- function(x) cpp_transition_type(x)

#' @rdname transition_type
#' @export
`transition_type<-` <- function(x, value) {
    cpp_transition_set_type(x, value)
    x
}

#' In and out offsets of a Transition
#' @param x A \code{Transition}.
#' @param value A \code{RationalTime}.
#' @return A \code{RationalTime}; the setter returns \code{x}.
#' @examples
#' tx <- Transition("d", transition_type = "SMPTE_Dissolve",
#'   in_offset = RationalTime(6, 24), out_offset = RationalTime(6, 24))
#' in_offset(tx)
#' out_offset(tx)
#' @export
in_offset <- function(x) cpp_transition_in_offset(x)

#' @rdname in_offset
#' @export
`in_offset<-` <- function(x, value) {
    cpp_transition_set_in_offset(x, value)
    x
}

#' @rdname in_offset
#' @export
out_offset <- function(x) cpp_transition_out_offset(x)

#' @rdname in_offset
#' @export
`out_offset<-` <- function(x, value) {
    cpp_transition_set_out_offset(x, value)
    x
}

# ---- Marker ----------------------------------------------------------

#' Marker color
#' @param x A \code{Marker}.
#' @param value A color string (e.g. \code{"RED"}, \code{"GREEN"}).
#' @return The color string; the setter returns \code{x}.
#' @examples
#' m <- Marker("m", marked_range = TimeRange(RationalTime(0, 24), RationalTime(1, 24)),
#'   color = "RED")
#' color(m)
#' @export
color <- function(x) cpp_marker_color(x)

#' @rdname color
#' @export
`color<-` <- function(x, value) {
    cpp_marker_set_color(x, value)
    x
}

#' Marked range of a Marker
#' @param x A \code{Marker}.
#' @param value A \code{TimeRange}.
#' @return A \code{TimeRange}; the setter returns \code{x}.
#' @examples
#' m <- Marker("m", marked_range = TimeRange(RationalTime(0, 24), RationalTime(1, 24)),
#'   color = "RED")
#' marked_range(m)
#' @export
marked_range <- function(x) cpp_marker_marked_range(x)

#' @rdname marked_range
#' @export
`marked_range<-` <- function(x, value) {
    cpp_marker_set_marked_range(x, value)
    x
}

#' Comment on a Marker
#' @param x A \code{Marker}.
#' @param value A comment string.
#' @return The comment; the setter returns \code{x}.
#' @examples
#' m <- Marker("m", marked_range = TimeRange(RationalTime(0, 24), RationalTime(1, 24)),
#'   color = "RED")
#' comment(m) <- "note"
#' comment(m)
#' @export
comment <- function(x) cpp_marker_comment(x)

#' @rdname comment
#' @export
`comment<-` <- function(x, value) {
    cpp_marker_set_comment(x, value)
    x
}

# ---- Effect / LinearTimeWarp -----------------------------------------

#' Effect name (the effect identifier, distinct from object name)
#' @param x An \code{Effect}.
#' @param value An effect identifier string.
#' @return The effect name; the setter returns \code{x}.
#' @examples
#' ef <- Effect("blur", effect_name = "GaussianBlur")
#' effect_name(ef)
#' @export
effect_name <- function(x) cpp_effect_name(x)

#' @rdname effect_name
#' @export
`effect_name<-` <- function(x, value) {
    cpp_effect_set_effect_name(x, value)
    x
}

#' Time scalar of a LinearTimeWarp
#' @param x A \code{LinearTimeWarp}.
#' @param value Numeric playback rate multiplier.
#' @return The time scalar; the setter returns \code{x}.
#' @examples
#' ltw <- LinearTimeWarp("speed", time_scalar = 2)
#' time_scalar(ltw)
#' time_scalar(ltw) <- 0.5
#' @export
time_scalar <- function(x) cpp_ltw_time_scalar(x)

#' @rdname time_scalar
#' @export
`time_scalar<-` <- function(x, value) {
    cpp_ltw_set_time_scalar(x, value)
    x
}
