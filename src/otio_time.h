#ifndef ROTIO_OTIO_TIME_H
#define ROTIO_OTIO_TIME_H

// OpenTime value-type conversions. RationalTime / TimeRange /
// TimeTransform are immutable value types, so they live as plain classed
// R values and are converted to/from C++ only at the call boundary:
//
//   RationalTime  -> numeric c(value=, rate=)          class "RationalTime"
//   TimeRange     -> list(start_time=, duration=)      class "TimeRange"
//   TimeTransform -> list(offset=, scale=, rate=)       class "TimeTransform"
//
// std::optional<T> maps to R NULL for the absent case.

#include <Rcpp.h>
#include <optional>
#include <opentime/rationalTime.h>
#include <opentime/timeRange.h>
#include <opentime/timeTransform.h>

// ---- RationalTime ----------------------------------------------------

namespace nle_detail {
// Read a named, finite numeric field from a RationalTime vector, with
// clear errors for malformed input crossing the R/C++ boundary.
inline double rt_field(SEXP x, const char* field) {
    if (TYPEOF(x) != REALSXP && TYPEOF(x) != INTSXP)
        Rcpp::stop("expected a RationalTime (a named numeric value/rate vector)");
    Rcpp::NumericVector v(x);
    SEXP nm = v.names();
    if (Rf_isNull(nm))
        Rcpp::stop("malformed RationalTime: vector has no 'value'/'rate' names");
    Rcpp::CharacterVector names(nm);
    for (R_xlen_t i = 0; i < names.size(); ++i) {
        if (std::string(names[i]) == field) {
            double d = v[i];
            if (Rcpp::NumericVector::is_na(d) || !R_finite(d))
                Rcpp::stop("malformed RationalTime: '%s' is NA or non-finite", field);
            return d;
        }
    }
    Rcpp::stop("malformed RationalTime: missing field '%s'", field);
    return 0;  // unreachable
}
}  // namespace nle_detail

inline ot::RationalTime as_rational_time(SEXP x) {
    if (Rf_isNull(x)) Rcpp::stop("expected a RationalTime, got NULL");
    return ot::RationalTime(nle_detail::rt_field(x, "value"),
                            nle_detail::rt_field(x, "rate"));
}

inline SEXP wrap_rational_time(ot::RationalTime const& t) {
    Rcpp::NumericVector v =
        Rcpp::NumericVector::create(Rcpp::_["value"] = t.value(),
                                    Rcpp::_["rate"]  = t.rate());
    v.attr("class") = "RationalTime";
    return v;
}

inline std::optional<ot::RationalTime> as_opt_rational_time(SEXP x) {
    if (Rf_isNull(x)) return std::nullopt;
    return as_rational_time(x);
}

inline SEXP wrap_opt_rational_time(std::optional<ot::RationalTime> const& t) {
    if (!t) return R_NilValue;
    return wrap_rational_time(*t);
}

// ---- TimeRange -------------------------------------------------------

inline ot::TimeRange as_time_range(SEXP x) {
    if (Rf_isNull(x)) Rcpp::stop("expected a TimeRange, got NULL");
    if (TYPEOF(x) != VECSXP)
        Rcpp::stop("expected a TimeRange (a list with start_time/duration)");
    Rcpp::List l(x);
    if (!l.containsElementNamed("start_time") || !l.containsElementNamed("duration"))
        Rcpp::stop("malformed TimeRange: needs 'start_time' and 'duration'");
    SEXP st = l["start_time"];
    SEXP du = l["duration"];
    return ot::TimeRange(as_rational_time(st), as_rational_time(du));
}

inline SEXP wrap_time_range(ot::TimeRange const& r) {
    Rcpp::List l =
        Rcpp::List::create(Rcpp::_["start_time"] = wrap_rational_time(r.start_time()),
                           Rcpp::_["duration"]   = wrap_rational_time(r.duration()));
    l.attr("class") = "TimeRange";
    return l;
}

inline std::optional<ot::TimeRange> as_opt_time_range(SEXP x) {
    if (Rf_isNull(x)) return std::nullopt;
    return as_time_range(x);
}

inline SEXP wrap_opt_time_range(std::optional<ot::TimeRange> const& r) {
    if (!r) return R_NilValue;
    return wrap_time_range(*r);
}

// ---- TimeTransform ---------------------------------------------------

inline ot::TimeTransform as_time_transform(SEXP x) {
    if (Rf_isNull(x)) Rcpp::stop("expected a TimeTransform, got NULL");
    if (TYPEOF(x) != VECSXP)
        Rcpp::stop("expected a TimeTransform (a list with offset/scale/rate)");
    Rcpp::List l(x);
    if (!l.containsElementNamed("offset") || !l.containsElementNamed("scale") ||
        !l.containsElementNamed("rate"))
        Rcpp::stop("malformed TimeTransform: needs 'offset', 'scale', 'rate'");
    SEXP off = l["offset"];
    double scale = Rcpp::as<double>(l["scale"]);
    double rate  = Rcpp::as<double>(l["rate"]);
    return ot::TimeTransform(as_rational_time(off), scale, rate);
}

inline SEXP wrap_time_transform(ot::TimeTransform const& t) {
    Rcpp::List l =
        Rcpp::List::create(Rcpp::_["offset"] = wrap_rational_time(t.offset()),
                           Rcpp::_["scale"]  = t.scale(),
                           Rcpp::_["rate"]   = t.rate());
    l.attr("class") = "TimeTransform";
    return l;
}

#endif // ROTIO_OTIO_TIME_H
