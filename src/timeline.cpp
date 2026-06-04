#include "rotio.h"

using namespace Rcpp;

// Timeline owns a Stack (its tracks). Timeline is not itself a Composition.

// [[Rcpp::export]]
SEXP cpp_timeline_tracks(SEXP x) {
    return otio_xptr(otio_get<otio::Timeline>(x)->tracks());
}

// [[Rcpp::export]]
void cpp_timeline_set_tracks(SEXP x, SEXP stack) {
    otio_get<otio::Timeline>(x)->set_tracks(otio_get<otio::Stack>(stack));
}

// [[Rcpp::export]]
SEXP cpp_timeline_global_start_time(SEXP x) {
    return wrap_opt_rational_time(otio_get<otio::Timeline>(x)->global_start_time());
}

// [[Rcpp::export]]
void cpp_timeline_set_global_start_time(SEXP x, SEXP global_start_time) {
    otio_get<otio::Timeline>(x)->set_global_start_time(as_opt_rational_time(global_start_time));
}

// [[Rcpp::export]]
SEXP cpp_timeline_duration(SEXP x) {
    otio::ErrorStatus err;
    ot::RationalTime d = otio_get<otio::Timeline>(x)->duration(&err);
    otio_check(err);
    return wrap_rational_time(d);
}

// [[Rcpp::export]]
Rcpp::List cpp_timeline_video_tracks(SEXP x) {
    return otio_xptr_list(otio_get<otio::Timeline>(x)->video_tracks());
}

// [[Rcpp::export]]
Rcpp::List cpp_timeline_audio_tracks(SEXP x) {
    return otio_xptr_list(otio_get<otio::Timeline>(x)->audio_tracks());
}

// [[Rcpp::export]]
Rcpp::List cpp_timeline_find_clips(SEXP x) {
    otio::ErrorStatus err;
    auto clips = otio_get<otio::Timeline>(x)->find_clips(&err);
    otio_check(err);
    std::vector<otio::Clip*> out;
    for (auto const& r : clips) out.push_back(r.value);
    return otio_xptr_list(out);
}

// ---- Track -----------------------------------------------------------

// [[Rcpp::export]]
std::string cpp_track_kind(SEXP x) {
    return otio_get<otio::Track>(x)->kind();
}

// [[Rcpp::export]]
void cpp_track_set_kind(SEXP x, std::string kind) {
    otio_get<otio::Track>(x)->set_kind(kind);
}
