#include "rotio.h"

using namespace Rcpp;

// RationalTime methods that need the C++ implementation (the plain
// value/rate accessors and the constructor live in R). Conversions go
// through as_rational_time() / wrap_rational_time().

// [[Rcpp::export]]
double cpp_rt_to_seconds(SEXP rt) {
    return as_rational_time(rt).to_seconds();
}

// [[Rcpp::export]]
SEXP cpp_rt_from_seconds(double seconds, double rate) {
    return wrap_rational_time(ot::RationalTime::from_seconds(seconds, rate));
}

// [[Rcpp::export]]
int cpp_rt_to_frames(SEXP rt) {
    return as_rational_time(rt).to_frames();
}

// [[Rcpp::export]]
SEXP cpp_rt_from_frames(double frame, double rate) {
    return wrap_rational_time(ot::RationalTime::from_frames(frame, rate));
}

// [[Rcpp::export]]
SEXP cpp_rt_rescaled_to(SEXP rt, double new_rate) {
    return wrap_rational_time(as_rational_time(rt).rescaled_to(new_rate));
}

// [[Rcpp::export]]
std::string cpp_rt_to_timecode(SEXP rt, double rate, int drop_frame) {
    ot::ErrorStatus err;
    std::string out = as_rational_time(rt).to_timecode(
        rate, static_cast<ot::IsDropFrameRate>(drop_frame), &err);
    otio_check(err);
    return out;
}

// [[Rcpp::export]]
SEXP cpp_rt_from_timecode(std::string timecode, double rate) {
    ot::ErrorStatus err;
    ot::RationalTime t = ot::RationalTime::from_timecode(timecode, rate, &err);
    otio_check(err);
    return wrap_rational_time(t);
}

// [[Rcpp::export]]
std::string cpp_rt_to_time_string(SEXP rt) {
    return as_rational_time(rt).to_time_string();
}

// [[Rcpp::export]]
SEXP cpp_rt_from_time_string(std::string time_string, double rate) {
    ot::ErrorStatus err;
    ot::RationalTime t = ot::RationalTime::from_time_string(time_string, rate, &err);
    otio_check(err);
    return wrap_rational_time(t);
}

// [[Rcpp::export]]
bool cpp_rt_almost_equal(SEXP a, SEXP b, double delta) {
    return as_rational_time(a).almost_equal(as_rational_time(b), delta);
}

// [[Rcpp::export]]
SEXP cpp_rt_add(SEXP a, SEXP b) {
    return wrap_rational_time(as_rational_time(a) + as_rational_time(b));
}

// [[Rcpp::export]]
SEXP cpp_rt_subtract(SEXP a, SEXP b) {
    return wrap_rational_time(as_rational_time(a) - as_rational_time(b));
}

// Three-way compare for R's Ops group generic: -1, 0, 1.
// [[Rcpp::export]]
int cpp_rt_compare(SEXP a, SEXP b) {
    ot::RationalTime x = as_rational_time(a), y = as_rational_time(b);
    if (x < y) return -1;
    if (x > y) return 1;
    return 0;
}

// ---- TimeRange -------------------------------------------------------

// [[Rcpp::export]]
SEXP cpp_tr_end_time_exclusive(SEXP tr) {
    return wrap_rational_time(as_time_range(tr).end_time_exclusive());
}

// [[Rcpp::export]]
SEXP cpp_tr_end_time_inclusive(SEXP tr) {
    return wrap_rational_time(as_time_range(tr).end_time_inclusive());
}

// [[Rcpp::export]]
SEXP cpp_tr_extended_by(SEXP tr, SEXP other) {
    return wrap_time_range(as_time_range(tr).extended_by(as_time_range(other)));
}

// [[Rcpp::export]]
SEXP cpp_tr_clamped_range(SEXP tr, SEXP other) {
    return wrap_time_range(as_time_range(tr).clamped(as_time_range(other)));
}

// [[Rcpp::export]]
bool cpp_tr_contains_time(SEXP tr, SEXP rt) {
    return as_time_range(tr).contains(as_rational_time(rt));
}

// [[Rcpp::export]]
bool cpp_tr_contains_range(SEXP tr, SEXP other, double epsilon_s) {
    return as_time_range(tr).contains(as_time_range(other), epsilon_s);
}

// [[Rcpp::export]]
bool cpp_tr_overlaps_range(SEXP tr, SEXP other, double epsilon_s) {
    return as_time_range(tr).overlaps(as_time_range(other), epsilon_s);
}

// [[Rcpp::export]]
bool cpp_tr_intersects(SEXP tr, SEXP other, double epsilon_s) {
    return as_time_range(tr).intersects(as_time_range(other), epsilon_s);
}

// [[Rcpp::export]]
SEXP cpp_tr_range_from_start_end_time(SEXP start_time, SEXP end_time_exclusive) {
    return wrap_time_range(ot::TimeRange::range_from_start_end_time(
        as_rational_time(start_time), as_rational_time(end_time_exclusive)));
}
