#include "rotio.h"

using namespace Rcpp;

// Composable / Item accessors. Tree *position* is range_in_parent();
// there is no stored "tl_in". Stored extent is source_range; full media
// extent is available_range; trimmed_range is source_range else available.

// ---- Composable ------------------------------------------------------

// [[Rcpp::export]]
bool cpp_visible(SEXP x) {
    return otio_get<otio::Composable>(x)->visible();
}

// [[Rcpp::export]]
bool cpp_overlapping(SEXP x) {
    return otio_get<otio::Composable>(x)->overlapping();
}

// Parent Composition, or NULL if unparented.
// [[Rcpp::export]]
SEXP cpp_parent(SEXP x) {
    return otio_xptr(otio_get<otio::Composable>(x)->parent());
}

// [[Rcpp::export]]
SEXP cpp_duration(SEXP x) {
    otio::ErrorStatus err;
    ot::RationalTime d = otio_get<otio::Composable>(x)->duration(&err);
    otio_check(err);
    return wrap_rational_time(d);
}

// ---- Item ------------------------------------------------------------

// [[Rcpp::export]]
SEXP cpp_source_range(SEXP x) {
    return wrap_opt_time_range(otio_get<otio::Item>(x)->source_range());
}

// [[Rcpp::export]]
void cpp_set_source_range(SEXP x, SEXP source_range) {
    otio_get<otio::Item>(x)->set_source_range(as_opt_time_range(source_range));
}

// [[Rcpp::export]]
bool cpp_enabled(SEXP x) {
    return otio_get<otio::Item>(x)->enabled();
}

// [[Rcpp::export]]
void cpp_set_enabled(SEXP x, bool enabled) {
    otio_get<otio::Item>(x)->set_enabled(enabled);
}

// [[Rcpp::export]]
SEXP cpp_available_range(SEXP x) {
    otio::ErrorStatus err;
    ot::TimeRange r = otio_get<otio::Item>(x)->available_range(&err);
    otio_check(err);
    return wrap_time_range(r);
}

// [[Rcpp::export]]
SEXP cpp_trimmed_range(SEXP x) {
    otio::ErrorStatus err;
    ot::TimeRange r = otio_get<otio::Item>(x)->trimmed_range(&err);
    otio_check(err);
    return wrap_time_range(r);
}

// [[Rcpp::export]]
SEXP cpp_visible_range(SEXP x) {
    otio::ErrorStatus err;
    ot::TimeRange r = otio_get<otio::Item>(x)->visible_range(&err);
    otio_check(err);
    return wrap_time_range(r);
}

// [[Rcpp::export]]
SEXP cpp_range_in_parent(SEXP x) {
    otio::ErrorStatus err;
    ot::TimeRange r = otio_get<otio::Item>(x)->range_in_parent(&err);
    otio_check(err);
    return wrap_time_range(r);
}

// [[Rcpp::export]]
SEXP cpp_trimmed_range_in_parent(SEXP x) {
    otio::ErrorStatus err;
    std::optional<ot::TimeRange> r = otio_get<otio::Item>(x)->trimmed_range_in_parent(&err);
    otio_check(err);
    return wrap_opt_time_range(r);
}
