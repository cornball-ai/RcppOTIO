#include "rotio.h"
#include <opentimelineio/editAlgorithm.h>
#include <opentimelineio/trackAlgorithm.h>
#include <opentimelineio/stackAlgorithm.h>

using namespace Rcpp;

// OTIO edit algorithms (opentimelineio::algo::*) plus the track/stack
// composition algorithms. The edit algorithms mutate a composition (or an
// item already in one) in place; track_trimmed_to_range and flatten_stack
// return new objects.
//
// fill_template defaults to nullptr (NULL from R), which is OTIO's own
// default: the algorithms then synthesise gaps themselves. Do NOT pass a
// hand-built empty Gap() as a template "default" -- that is not the same
// thing and gives wrong gap sizing. Behaviour is verified by the tests,
// not assumed from the header diagrams.

static otio::Item* opt_item(SEXP x) {
    return Rf_isNull(x) ? nullptr : otio_get<otio::Item>(x);
}

static otio::algo::ReferencePoint parse_reference_point(std::string const& s) {
    if (s == "Source")   return otio::algo::ReferencePoint::Source;
    if (s == "Sequence") return otio::algo::ReferencePoint::Sequence;
    if (s == "Fit")      return otio::algo::ReferencePoint::Fit;
    Rcpp::stop("reference_point must be 'Source', 'Sequence', or 'Fit'");
}

// [[Rcpp::export]]
void cpp_algo_overwrite(SEXP item, SEXP composition, SEXP range,
                        bool remove_transitions, SEXP fill_template) {
    otio::ErrorStatus err;
    otio::algo::overwrite(otio_get<otio::Item>(item),
                          otio_get<otio::Composition>(composition),
                          as_time_range(range), remove_transitions,
                          opt_item(fill_template), &err);
    otio_check(err);
}

// [[Rcpp::export]]
void cpp_algo_insert(SEXP item, SEXP composition, SEXP time,
                     bool remove_transitions, SEXP fill_template) {
    otio::ErrorStatus err;
    otio::algo::insert(otio_get<otio::Item>(item),
                       otio_get<otio::Composition>(composition),
                       as_rational_time(time), remove_transitions,
                       opt_item(fill_template), &err);
    otio_check(err);
}

// [[Rcpp::export]]
void cpp_algo_trim(SEXP item, SEXP delta_in, SEXP delta_out, SEXP fill_template) {
    otio::ErrorStatus err;
    otio::algo::trim(otio_get<otio::Item>(item),
                     as_rational_time(delta_in), as_rational_time(delta_out),
                     opt_item(fill_template), &err);
    otio_check(err);
}

// [[Rcpp::export]]
void cpp_algo_slice(SEXP composition, SEXP time, bool remove_transitions) {
    otio::ErrorStatus err;
    otio::algo::slice(otio_get<otio::Composition>(composition),
                      as_rational_time(time), remove_transitions, &err);
    otio_check(err);
}

// slip and slide take no ErrorStatus in OTIO.
// [[Rcpp::export]]
void cpp_algo_slip(SEXP item, SEXP delta) {
    otio::algo::slip(otio_get<otio::Item>(item), as_rational_time(delta));
}

// [[Rcpp::export]]
void cpp_algo_slide(SEXP item, SEXP delta) {
    otio::algo::slide(otio_get<otio::Item>(item), as_rational_time(delta));
}

// [[Rcpp::export]]
void cpp_algo_ripple(SEXP item, SEXP delta_in, SEXP delta_out) {
    otio::ErrorStatus err;
    otio::algo::ripple(otio_get<otio::Item>(item),
                       as_rational_time(delta_in), as_rational_time(delta_out), &err);
    otio_check(err);
}

// [[Rcpp::export]]
void cpp_algo_roll(SEXP item, SEXP delta_in, SEXP delta_out) {
    otio::ErrorStatus err;
    otio::algo::roll(otio_get<otio::Item>(item),
                     as_rational_time(delta_in), as_rational_time(delta_out), &err);
    otio_check(err);
}

// [[Rcpp::export]]
void cpp_algo_fill(SEXP item, SEXP track, SEXP track_time, std::string reference_point) {
    otio::ErrorStatus err;
    otio::algo::fill(otio_get<otio::Item>(item),
                     otio_get<otio::Composition>(track),
                     as_rational_time(track_time),
                     parse_reference_point(reference_point), &err);
    otio_check(err);
}

// [[Rcpp::export]]
void cpp_algo_remove(SEXP composition, SEXP time, bool fill, SEXP fill_template) {
    otio::ErrorStatus err;
    otio::algo::remove(otio_get<otio::Composition>(composition),
                       as_rational_time(time), fill, opt_item(fill_template), &err);
    otio_check(err);
}

// ---- Composition algorithms (return new objects) ---------------------

// [[Rcpp::export]]
SEXP cpp_track_trimmed_to_range(SEXP track, SEXP trim_range) {
    otio::ErrorStatus err;
    otio::Track* out = otio::track_trimmed_to_range(
        otio_get<otio::Track>(track), as_time_range(trim_range), &err);
    otio_check(err);
    return otio_xptr(out);
}

// [[Rcpp::export]]
SEXP cpp_flatten_stack(SEXP stack) {
    otio::ErrorStatus err;
    otio::Track* out = otio::flatten_stack(otio_get<otio::Stack>(stack), &err);
    otio_check(err);
    return otio_xptr(out);
}

// [[Rcpp::export]]
SEXP cpp_flatten_stack_tracks(Rcpp::List tracks) {
    std::vector<otio::Track*> ts;
    ts.reserve(tracks.size());
    for (R_xlen_t i = 0; i < tracks.size(); ++i)
        ts.push_back(otio_get<otio::Track>(tracks[i]));
    otio::ErrorStatus err;
    otio::Track* out = otio::flatten_stack(ts, &err);
    otio_check(err);
    return otio_xptr(out);
}
