#include "rotio.h"
#include <opentimelineio/serializableObject.h>
#include <typeinfo>

using namespace Rcpp;

// ---- R -> std::any ---------------------------------------------------

static std::any atomic_element_to_any(SEXP x, R_xlen_t i) {
    switch (TYPEOF(x)) {
        case LGLSXP: return otio::create_safely_typed_any(
                         (bool) (LOGICAL(x)[i] == TRUE));
        case INTSXP: return otio::create_safely_typed_any(
                         (int64_t) INTEGER(x)[i]);
        case REALSXP: return otio::create_safely_typed_any(
                         (double) REAL(x)[i]);
        case STRSXP: return otio::create_safely_typed_any(
                         std::string(CHAR(STRING_ELT(x, i))));
        default: Rcpp::stop("unsupported metadata element type");
    }
    return std::any();
}

std::any r_to_any(SEXP x) {
    if (Rf_isNull(x)) return std::any();

    if (Rf_inherits(x, "RationalTime")) {
        ot::RationalTime t = as_rational_time(x);
        return otio::create_safely_typed_any(std::move(t));
    }
    if (Rf_inherits(x, "TimeRange")) {
        ot::TimeRange r = as_time_range(x);
        return otio::create_safely_typed_any(std::move(r));
    }
    if (Rf_inherits(x, "TimeTransform")) {
        ot::TimeTransform t = as_time_transform(x);
        return otio::create_safely_typed_any(std::move(t));
    }
    if (TYPEOF(x) == EXTPTRSXP) {
        return otio::create_safely_typed_any(otio_get<otio::SerializableObject>(x));
    }
    if (TYPEOF(x) == VECSXP) {
        SEXP nms = Rf_getAttrib(x, R_NamesSymbol);
        if (!Rf_isNull(nms)) {                 // named list -> AnyDictionary
            return otio::create_safely_typed_any(as_any_dictionary(x));
        }
        otio::AnyVector av;                    // unnamed list -> AnyVector
        for (R_xlen_t i = 0; i < Rf_xlength(x); ++i) av.push_back(r_to_any(VECTOR_ELT(x, i)));
        return otio::create_safely_typed_any(std::move(av));
    }

    R_xlen_t n = Rf_xlength(x);
    if (n == 1) return atomic_element_to_any(x, 0);
    otio::AnyVector av;                        // length > 1 atomic -> AnyVector
    for (R_xlen_t i = 0; i < n; ++i) av.push_back(atomic_element_to_any(x, i));
    return otio::create_safely_typed_any(std::move(av));
}

// ---- std::any -> R ---------------------------------------------------

SEXP any_to_r(std::any const& a) {
    if (!a.has_value()) return R_NilValue;
    std::type_info const& t = a.type();

    if (t == typeid(bool))        return Rcpp::wrap(otio::safely_cast_bool_any(a));
    if (t == typeid(int))         return Rcpp::wrap(otio::safely_cast_int_any(a));
    if (t == typeid(int64_t))     return Rcpp::wrap((double) otio::safely_cast_int64_any(a));
    if (t == typeid(uint64_t))    return Rcpp::wrap((double) otio::safely_cast_uint64_any(a));
    if (t == typeid(double))      return Rcpp::wrap(otio::safely_cast_double_any(a));
    if (t == typeid(std::string)) return Rcpp::wrap(otio::safely_cast_string_any(a));
    if (t == typeid(ot::RationalTime))
        return wrap_rational_time(otio::safely_cast_rational_time_any(a));
    if (t == typeid(ot::TimeRange))
        return wrap_time_range(otio::safely_cast_time_range_any(a));
    if (t == typeid(ot::TimeTransform))
        return wrap_time_transform(otio::safely_cast_time_transform_any(a));
    if (t == typeid(otio::AnyDictionary))
        return wrap_any_dictionary(otio::safely_cast_any_dictionary_any(a));
    if (t == typeid(otio::AnyVector)) {
        otio::AnyVector av = otio::safely_cast_any_vector_any(a);
        Rcpp::List out(av.size());
        for (size_t i = 0; i < av.size(); ++i) out[i] = any_to_r(av[i]);
        return out;
    }
    if (t == typeid(OtioRetainer))
        return otio_xptr(otio::safely_cast_retainer_any(a));

    Rcpp::warning("dropping metadata value of unsupported type '%s'", t.name());
    return R_NilValue;
}

// ---- AnyDictionary <-> R named list ----------------------------------

otio::AnyDictionary as_any_dictionary(SEXP x) {
    otio::AnyDictionary d;
    if (Rf_isNull(x)) return d;
    Rcpp::List l(x);
    if (l.size() == 0) return d;                 // empty list -> empty dict
    SEXP names = Rf_getAttrib(l, R_NamesSymbol);
    if (Rf_isNull(names)) Rcpp::stop("metadata must be a named list");
    Rcpp::CharacterVector nms(names);
    for (R_xlen_t i = 0; i < l.size(); ++i) {
        std::string key = Rcpp::as<std::string>(nms[i]);
        d[key] = r_to_any(l[i]);
    }
    return d;
}

SEXP wrap_any_dictionary(otio::AnyDictionary const& d) {
    Rcpp::List out(d.size());
    Rcpp::CharacterVector nms(d.size());
    R_xlen_t i = 0;
    for (auto const& kv : d) {
        nms[i] = kv.first;
        out[i] = any_to_r(kv.second);
        ++i;
    }
    out.names() = nms;
    return out;
}
