#include "RcppOTIO.h"

using namespace Rcpp;

// JSON round-trip uses OTIO's own SerializableObject methods, which carry
// schema name/version and route unknown schemas through the type registry.

// A named integer vector -> schema_version_map (schema name -> target
// version). Passing this to a to_json call asks OTIO to downgrade each
// object to the target version using registered downgrade functions.
static otio::schema_version_map as_schema_version_map(SEXP x) {
    otio::schema_version_map m;
    if (Rf_isNull(x)) return m;
    Rcpp::IntegerVector v(x);
    SEXP names = Rf_getAttrib(v, R_NamesSymbol);
    if (Rf_isNull(names))
        Rcpp::stop("target_schema_versions must be a named integer vector (schema -> version)");
    Rcpp::CharacterVector nms(names);
    for (R_xlen_t i = 0; i < v.size(); ++i) {
        if (Rcpp::CharacterVector::is_na(nms[i]))
            Rcpp::stop("target_schema_versions names must not be NA");
        std::string key = Rcpp::as<std::string>(nms[i]);
        if (m.count(key))                 // backstop: don't silently collapse dupes
            Rcpp::stop("duplicate target_schema_versions name '%s'", key);
        m[key] = static_cast<int64_t>(v[i]);
    }
    return m;
}

// [[Rcpp::export]]
std::string cpp_to_json_string(SEXP x, int indent, SEXP target_schema_versions) {
    otio::SerializableObject* obj = otio_get<otio::SerializableObject>(x);
    otio::schema_version_map m = as_schema_version_map(target_schema_versions);
    bool has_target = !Rf_isNull(target_schema_versions);
    otio::ErrorStatus err;
    std::string out = obj->to_json_string(&err, has_target ? &m : nullptr, indent);
    otio_check(err);
    return out;
}

// [[Rcpp::export]]
bool cpp_to_json_file(SEXP x, std::string file_name, int indent, SEXP target_schema_versions) {
    otio::SerializableObject* obj = otio_get<otio::SerializableObject>(x);
    otio::schema_version_map m = as_schema_version_map(target_schema_versions);
    bool has_target = !Rf_isNull(target_schema_versions);
    otio::ErrorStatus err;
    bool ok = obj->to_json_file(file_name, &err, has_target ? &m : nullptr, indent);
    otio_check(err);
    return ok;
}

// [[Rcpp::export]]
SEXP cpp_from_json_string(std::string input) {
    otio::ErrorStatus err;
    otio::SerializableObject* obj = otio::SerializableObject::from_json_string(input, &err);
    otio_check(err);
    return otio_xptr(obj);
}

// [[Rcpp::export]]
SEXP cpp_from_json_file(std::string file_name) {
    otio::ErrorStatus err;
    otio::SerializableObject* obj = otio::SerializableObject::from_json_file(file_name, &err);
    otio_check(err);
    return otio_xptr(obj);
}

// [[Rcpp::export]]
SEXP cpp_clone(SEXP x) {
    otio::SerializableObject* obj = otio_get<otio::SerializableObject>(x);
    otio::ErrorStatus err;
    otio::SerializableObject* c = obj->clone(&err);
    otio_check(err);
    return otio_xptr(c);
}

// [[Rcpp::export]]
std::string cpp_schema_name(SEXP x) {
    return otio_get<otio::SerializableObject>(x)->schema_name();
}

// [[Rcpp::export]]
int cpp_schema_version(SEXP x) {
    return otio_get<otio::SerializableObject>(x)->schema_version();
}

// [[Rcpp::export]]
bool cpp_is_equivalent_to(SEXP x, SEXP other) {
    return otio_get<otio::SerializableObject>(x)->is_equivalent_to(
        *otio_get<otio::SerializableObject>(other));
}

// [[Rcpp::export]]
bool cpp_is_unknown_schema(SEXP x) {
    return otio_get<otio::SerializableObject>(x)->is_unknown_schema();
}

// ---- name / metadata (SerializableObjectWithMetadata) ----------------

// [[Rcpp::export]]
std::string cpp_name(SEXP x) {
    return otio_get<otio::SerializableObjectWithMetadata>(x)->name();
}

// [[Rcpp::export]]
void cpp_set_name(SEXP x, std::string name) {
    otio_get<otio::SerializableObjectWithMetadata>(x)->set_name(name);
}

// [[Rcpp::export]]
SEXP cpp_metadata(SEXP x) {
    return wrap_any_dictionary(otio_get<otio::SerializableObjectWithMetadata>(x)->metadata());
}

// [[Rcpp::export]]
void cpp_set_metadata(SEXP x, SEXP value) {
    otio_get<otio::SerializableObjectWithMetadata>(x)->metadata() = as_any_dictionary(value);
}
