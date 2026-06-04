#include "rotio.h"

using namespace Rcpp;

// Constructors for every concrete schema class in the first-cut surface.
// A freshly-`new`ed OTIO object has a zero reference count; otio_xptr()
// wraps it in a Retainer (+1), so it stays alive for as long as the R
// handle (or a tree parent) holds a reference. Effects/markers vectors
// are left empty at construction; manage them via accessors.

// [[Rcpp::export]]
SEXP cpp_new_timeline(std::string name, SEXP global_start_time, SEXP metadata) {
    return otio_xptr(new otio::Timeline(
        name, as_opt_rational_time(global_start_time), as_any_dictionary(metadata)));
}

// [[Rcpp::export]]
SEXP cpp_new_stack(std::string name, SEXP source_range, SEXP metadata) {
    return otio_xptr(new otio::Stack(
        name, as_opt_time_range(source_range), as_any_dictionary(metadata)));
}

// [[Rcpp::export]]
SEXP cpp_new_track(std::string name, SEXP source_range, std::string kind, SEXP metadata) {
    return otio_xptr(new otio::Track(
        name, as_opt_time_range(source_range), kind, as_any_dictionary(metadata)));
}

// [[Rcpp::export]]
SEXP cpp_new_clip(std::string name, SEXP media_reference, SEXP source_range, SEXP metadata) {
    otio::MediaReference* mr =
        Rf_isNull(media_reference) ? nullptr : otio_get<otio::MediaReference>(media_reference);
    return otio_xptr(new otio::Clip(
        name, mr, as_opt_time_range(source_range), as_any_dictionary(metadata)));
}

// Gap by duration (the RationalTime overload).
// [[Rcpp::export]]
SEXP cpp_new_gap(SEXP duration, std::string name, SEXP metadata) {
    return otio_xptr(new otio::Gap(
        as_rational_time(duration), name,
        std::vector<otio::Effect*>(), std::vector<otio::Marker*>(),
        as_any_dictionary(metadata)));
}

// [[Rcpp::export]]
SEXP cpp_new_transition(std::string name, std::string transition_type,
                        SEXP in_offset, SEXP out_offset, SEXP metadata) {
    return otio_xptr(new otio::Transition(
        name, transition_type, as_rational_time(in_offset), as_rational_time(out_offset),
        as_any_dictionary(metadata)));
}

// [[Rcpp::export]]
SEXP cpp_new_marker(std::string name, SEXP marked_range, std::string color,
                    SEXP metadata, std::string comment) {
    return otio_xptr(new otio::Marker(
        name, as_time_range(marked_range), color, as_any_dictionary(metadata), comment));
}

// [[Rcpp::export]]
SEXP cpp_new_effect(std::string name, std::string effect_name, SEXP metadata, bool enabled) {
    return otio_xptr(new otio::Effect(name, effect_name, as_any_dictionary(metadata), enabled));
}

// [[Rcpp::export]]
SEXP cpp_new_time_effect(std::string name, std::string effect_name, SEXP metadata) {
    return otio_xptr(new otio::TimeEffect(name, effect_name, as_any_dictionary(metadata)));
}

// [[Rcpp::export]]
SEXP cpp_new_linear_time_warp(std::string name, std::string effect_name,
                              double time_scalar, SEXP metadata) {
    return otio_xptr(new otio::LinearTimeWarp(
        name, effect_name, time_scalar, as_any_dictionary(metadata)));
}

// [[Rcpp::export]]
SEXP cpp_new_freeze_frame(std::string name, SEXP metadata) {
    return otio_xptr(new otio::FreezeFrame(name, as_any_dictionary(metadata)));
}

// ---- Media references ------------------------------------------------

// [[Rcpp::export]]
SEXP cpp_new_media_reference(std::string name, SEXP available_range, SEXP metadata) {
    return otio_xptr(new otio::MediaReference(
        name, as_opt_time_range(available_range), as_any_dictionary(metadata)));
}

// [[Rcpp::export]]
SEXP cpp_new_external_reference(std::string target_url, SEXP available_range, SEXP metadata) {
    return otio_xptr(new otio::ExternalReference(
        target_url, as_opt_time_range(available_range), as_any_dictionary(metadata)));
}

// [[Rcpp::export]]
SEXP cpp_new_image_sequence_reference(
        std::string target_url_base, std::string name_prefix, std::string name_suffix,
        int start_frame, int frame_step, double rate, int frame_zero_padding,
        int missing_frame_policy, SEXP available_range, SEXP metadata) {
    return otio_xptr(new otio::ImageSequenceReference(
        target_url_base, name_prefix, name_suffix, start_frame, frame_step, rate,
        frame_zero_padding,
        static_cast<otio::ImageSequenceReference::MissingFramePolicy>(missing_frame_policy),
        as_opt_time_range(available_range), as_any_dictionary(metadata)));
}

// [[Rcpp::export]]
SEXP cpp_new_generator_reference(std::string name, std::string generator_kind,
                                 SEXP available_range, SEXP parameters, SEXP metadata) {
    return otio_xptr(new otio::GeneratorReference(
        name, generator_kind, as_opt_time_range(available_range),
        as_any_dictionary(parameters), as_any_dictionary(metadata)));
}

// [[Rcpp::export]]
SEXP cpp_new_missing_reference(std::string name, SEXP available_range, SEXP metadata) {
    return otio_xptr(new otio::MissingReference(
        name, as_opt_time_range(available_range), as_any_dictionary(metadata)));
}

// ---- SerializableCollection ------------------------------------------

// [[Rcpp::export]]
SEXP cpp_new_serializable_collection(std::string name, Rcpp::List children, SEXP metadata) {
    std::vector<otio::SerializableObject*> kids;
    kids.reserve(children.size());
    for (R_xlen_t i = 0; i < children.size(); ++i)
        kids.push_back(otio_get<otio::SerializableObject>(children[i]));
    return otio_xptr(new otio::SerializableCollection(name, kids, as_any_dictionary(metadata)));
}
