#include "RcppOTIO.h"

using namespace Rcpp;

// Simple field accessors for Effect, LinearTimeWarp, Transition, Marker.

// ---- Effect ----------------------------------------------------------

// [[Rcpp::export]]
std::string cpp_effect_name(SEXP x) {
    return otio_get<otio::Effect>(x)->effect_name();
}

// [[Rcpp::export]]
void cpp_effect_set_effect_name(SEXP x, std::string effect_name) {
    otio_get<otio::Effect>(x)->set_effect_name(effect_name);
}

// [[Rcpp::export]]
bool cpp_effect_enabled(SEXP x) {
    return otio_get<otio::Effect>(x)->enabled();
}

// [[Rcpp::export]]
void cpp_effect_set_enabled(SEXP x, bool enabled) {
    otio_get<otio::Effect>(x)->set_enabled(enabled);
}

// ---- LinearTimeWarp --------------------------------------------------

// [[Rcpp::export]]
double cpp_ltw_time_scalar(SEXP x) {
    return otio_get<otio::LinearTimeWarp>(x)->time_scalar();
}

// [[Rcpp::export]]
void cpp_ltw_set_time_scalar(SEXP x, double time_scalar) {
    otio_get<otio::LinearTimeWarp>(x)->set_time_scalar(time_scalar);
}

// ---- Transition ------------------------------------------------------

// [[Rcpp::export]]
std::string cpp_transition_type(SEXP x) {
    return otio_get<otio::Transition>(x)->transition_type();
}

// [[Rcpp::export]]
void cpp_transition_set_type(SEXP x, std::string transition_type) {
    otio_get<otio::Transition>(x)->set_transition_type(transition_type);
}

// [[Rcpp::export]]
SEXP cpp_transition_in_offset(SEXP x) {
    return wrap_rational_time(otio_get<otio::Transition>(x)->in_offset());
}

// [[Rcpp::export]]
void cpp_transition_set_in_offset(SEXP x, SEXP in_offset) {
    otio_get<otio::Transition>(x)->set_in_offset(as_rational_time(in_offset));
}

// [[Rcpp::export]]
SEXP cpp_transition_out_offset(SEXP x) {
    return wrap_rational_time(otio_get<otio::Transition>(x)->out_offset());
}

// [[Rcpp::export]]
void cpp_transition_set_out_offset(SEXP x, SEXP out_offset) {
    otio_get<otio::Transition>(x)->set_out_offset(as_rational_time(out_offset));
}

// Transition is a Composable, not an Item, and has its own range methods
// that return std::optional (NULL when the transition has no parent).
// [[Rcpp::export]]
SEXP cpp_transition_range_in_parent(SEXP x) {
    otio::ErrorStatus err;
    std::optional<ot::TimeRange> r = otio_get<otio::Transition>(x)->range_in_parent(&err);
    otio_check(err);
    return wrap_opt_time_range(r);
}

// [[Rcpp::export]]
SEXP cpp_transition_trimmed_range_in_parent(SEXP x) {
    otio::ErrorStatus err;
    std::optional<ot::TimeRange> r = otio_get<otio::Transition>(x)->trimmed_range_in_parent(&err);
    otio_check(err);
    return wrap_opt_time_range(r);
}

// ---- Marker ----------------------------------------------------------

// [[Rcpp::export]]
std::string cpp_marker_color(SEXP x) {
    return otio_get<otio::Marker>(x)->color();
}

// [[Rcpp::export]]
void cpp_marker_set_color(SEXP x, std::string color) {
    otio_get<otio::Marker>(x)->set_color(color);
}

// [[Rcpp::export]]
SEXP cpp_marker_marked_range(SEXP x) {
    return wrap_time_range(otio_get<otio::Marker>(x)->marked_range());
}

// [[Rcpp::export]]
void cpp_marker_set_marked_range(SEXP x, SEXP marked_range) {
    otio_get<otio::Marker>(x)->set_marked_range(as_time_range(marked_range));
}

// [[Rcpp::export]]
std::string cpp_marker_comment(SEXP x) {
    return otio_get<otio::Marker>(x)->comment();
}

// [[Rcpp::export]]
void cpp_marker_set_comment(SEXP x, std::string comment) {
    otio_get<otio::Marker>(x)->set_comment(comment);
}
