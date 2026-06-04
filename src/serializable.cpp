#include "rotio.h"

using namespace Rcpp;

// JSON round-trip uses OTIO's own SerializableObject methods, which carry
// schema name/version and route unknown schemas through the type registry.

// [[Rcpp::export]]
std::string cpp_to_json_string(SEXP x, int indent) {
    otio::SerializableObject* obj = otio_get<otio::SerializableObject>(x);
    otio::ErrorStatus err;
    std::string out = obj->to_json_string(&err, nullptr, indent);
    otio_check(err);
    return out;
}

// [[Rcpp::export]]
bool cpp_to_json_file(SEXP x, std::string file_name, int indent) {
    otio::SerializableObject* obj = otio_get<otio::SerializableObject>(x);
    otio::ErrorStatus err;
    bool ok = obj->to_json_file(file_name, &err, nullptr, indent);
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
