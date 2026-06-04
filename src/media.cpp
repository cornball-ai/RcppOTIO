#include "rotio.h"

using namespace Rcpp;

// Clip media binding plus the four MediaReference subtypes. The first cut
// exposes the active media reference and key; the full media_references
// map is deferred.

// ---- Clip ------------------------------------------------------------

// [[Rcpp::export]]
SEXP cpp_clip_media_reference(SEXP x) {
    return otio_xptr(otio_get<otio::Clip>(x)->media_reference());
}

// [[Rcpp::export]]
void cpp_clip_set_media_reference(SEXP x, SEXP media_reference) {
    otio::MediaReference* mr =
        Rf_isNull(media_reference) ? nullptr : otio_get<otio::MediaReference>(media_reference);
    otio_get<otio::Clip>(x)->set_media_reference(mr);
}

// [[Rcpp::export]]
std::string cpp_clip_active_media_reference_key(SEXP x) {
    return otio_get<otio::Clip>(x)->active_media_reference_key();
}

// [[Rcpp::export]]
void cpp_clip_set_active_media_reference_key(SEXP x, std::string key) {
    otio::ErrorStatus err;
    otio_get<otio::Clip>(x)->set_active_media_reference_key(key, &err);
    otio_check(err);
}

// [[Rcpp::export]]
std::string cpp_clip_default_media_key() {
    return otio::Clip::default_media_key;
}

// ---- MediaReference (base) -------------------------------------------

// [[Rcpp::export]]
SEXP cpp_mediaref_available_range(SEXP x) {
    return wrap_opt_time_range(otio_get<otio::MediaReference>(x)->available_range());
}

// [[Rcpp::export]]
void cpp_mediaref_set_available_range(SEXP x, SEXP available_range) {
    otio_get<otio::MediaReference>(x)->set_available_range(as_opt_time_range(available_range));
}

// [[Rcpp::export]]
bool cpp_mediaref_is_missing_reference(SEXP x) {
    return otio_get<otio::MediaReference>(x)->is_missing_reference();
}

// ---- ExternalReference -----------------------------------------------

// [[Rcpp::export]]
std::string cpp_extref_target_url(SEXP x) {
    return otio_get<otio::ExternalReference>(x)->target_url();
}

// [[Rcpp::export]]
void cpp_extref_set_target_url(SEXP x, std::string target_url) {
    otio_get<otio::ExternalReference>(x)->set_target_url(target_url);
}

// ---- ImageSequenceReference ------------------------------------------

// [[Rcpp::export]]
std::string cpp_imgseq_target_url_base(SEXP x) {
    return otio_get<otio::ImageSequenceReference>(x)->target_url_base();
}

// [[Rcpp::export]]
void cpp_imgseq_set_target_url_base(SEXP x, std::string v) {
    otio_get<otio::ImageSequenceReference>(x)->set_target_url_base(v);
}

// [[Rcpp::export]]
std::string cpp_imgseq_name_prefix(SEXP x) {
    return otio_get<otio::ImageSequenceReference>(x)->name_prefix();
}

// [[Rcpp::export]]
std::string cpp_imgseq_name_suffix(SEXP x) {
    return otio_get<otio::ImageSequenceReference>(x)->name_suffix();
}

// [[Rcpp::export]]
int cpp_imgseq_start_frame(SEXP x) {
    return otio_get<otio::ImageSequenceReference>(x)->start_frame();
}

// [[Rcpp::export]]
int cpp_imgseq_frame_step(SEXP x) {
    return otio_get<otio::ImageSequenceReference>(x)->frame_step();
}

// [[Rcpp::export]]
double cpp_imgseq_rate(SEXP x) {
    return otio_get<otio::ImageSequenceReference>(x)->rate();
}

// [[Rcpp::export]]
int cpp_imgseq_frame_zero_padding(SEXP x) {
    return otio_get<otio::ImageSequenceReference>(x)->frame_zero_padding();
}

// [[Rcpp::export]]
int cpp_imgseq_end_frame(SEXP x) {
    return otio_get<otio::ImageSequenceReference>(x)->end_frame();
}

// [[Rcpp::export]]
int cpp_imgseq_number_of_images_in_sequence(SEXP x) {
    return otio_get<otio::ImageSequenceReference>(x)->number_of_images_in_sequence();
}

// [[Rcpp::export]]
int cpp_imgseq_frame_for_time(SEXP x, SEXP time) {
    otio::ErrorStatus err;
    int f = otio_get<otio::ImageSequenceReference>(x)->frame_for_time(as_rational_time(time), &err);
    otio_check(err);
    return f;
}

// [[Rcpp::export]]
std::string cpp_imgseq_target_url_for_image_number(SEXP x, int image_number) {
    otio::ErrorStatus err;
    std::string u =
        otio_get<otio::ImageSequenceReference>(x)->target_url_for_image_number(image_number, &err);
    otio_check(err);
    return u;
}

// [[Rcpp::export]]
SEXP cpp_imgseq_presentation_time_for_image_number(SEXP x, int image_number) {
    otio::ErrorStatus err;
    ot::RationalTime t =
        otio_get<otio::ImageSequenceReference>(x)->presentation_time_for_image_number(image_number, &err);
    otio_check(err);
    return wrap_rational_time(t);
}

// ---- GeneratorReference ----------------------------------------------

// [[Rcpp::export]]
std::string cpp_genref_generator_kind(SEXP x) {
    return otio_get<otio::GeneratorReference>(x)->generator_kind();
}

// [[Rcpp::export]]
void cpp_genref_set_generator_kind(SEXP x, std::string generator_kind) {
    otio_get<otio::GeneratorReference>(x)->set_generator_kind(generator_kind);
}

// [[Rcpp::export]]
SEXP cpp_genref_parameters(SEXP x) {
    return wrap_any_dictionary(otio_get<otio::GeneratorReference>(x)->parameters());
}

// [[Rcpp::export]]
void cpp_genref_set_parameters(SEXP x, SEXP parameters) {
    otio_get<otio::GeneratorReference>(x)->parameters() = as_any_dictionary(parameters);
}
