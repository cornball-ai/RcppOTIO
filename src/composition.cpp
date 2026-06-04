#include "rotio.h"

using namespace Rcpp;

// Composition tree operations. Children are addressed by 0-based index at
// this C++ layer (the R wrappers present 1-based indices) and by object
// reference, never by name: siblings may share a name.

// [[Rcpp::export]]
Rcpp::List cpp_children(SEXP x) {
    otio::Composition* comp = otio_get<otio::Composition>(x);
    std::vector<otio::Composable*> kids;
    for (auto const& r : comp->children()) kids.push_back(r.value);
    return otio_xptr_list(kids);
}

// SerializableCollection holds SerializableObjects (not Composables) and
// is not a Composition, so it has its own children() accessor and its own
// mutation methods. Indices are 0-based here (R wrappers present 1-based).
// [[Rcpp::export]]
Rcpp::List cpp_collection_children(SEXP x) {
    otio::SerializableCollection* coll = otio_get<otio::SerializableCollection>(x);
    std::vector<otio::SerializableObject*> kids;
    for (auto const& r : coll->children()) kids.push_back(r.value);
    return otio_xptr_list(kids);
}

// [[Rcpp::export]]
void cpp_collection_set_children(SEXP x, Rcpp::List children) {
    std::vector<otio::SerializableObject*> kids;
    kids.reserve(children.size());
    for (R_xlen_t i = 0; i < children.size(); ++i)
        kids.push_back(otio_get<otio::SerializableObject>(children[i]));
    otio_get<otio::SerializableCollection>(x)->set_children(kids);
}

// [[Rcpp::export]]
void cpp_collection_clear_children(SEXP x) {
    otio_get<otio::SerializableCollection>(x)->clear_children();
}

// [[Rcpp::export]]
void cpp_collection_insert_child(SEXP x, int index, SEXP child) {
    otio_get<otio::SerializableCollection>(x)->insert_child(
        index, otio_get<otio::SerializableObject>(child));
}

// [[Rcpp::export]]
void cpp_collection_set_child(SEXP x, int index, SEXP child) {
    otio::ErrorStatus err;
    otio_get<otio::SerializableCollection>(x)->set_child(
        index, otio_get<otio::SerializableObject>(child), &err);
    otio_check(err);
}

// [[Rcpp::export]]
void cpp_collection_remove_child(SEXP x, int index) {
    otio::ErrorStatus err;
    otio_get<otio::SerializableCollection>(x)->remove_child(index, &err);
    otio_check(err);
}

// [[Rcpp::export]]
void cpp_append_child(SEXP x, SEXP child) {
    otio::ErrorStatus err;
    otio_get<otio::Composition>(x)->append_child(otio_get<otio::Composable>(child), &err);
    otio_check(err);
}

// index is 0-based.
// [[Rcpp::export]]
void cpp_insert_child(SEXP x, int index, SEXP child) {
    otio::ErrorStatus err;
    otio_get<otio::Composition>(x)->insert_child(index, otio_get<otio::Composable>(child), &err);
    otio_check(err);
}

// [[Rcpp::export]]
void cpp_set_child(SEXP x, int index, SEXP child) {
    otio::ErrorStatus err;
    otio_get<otio::Composition>(x)->set_child(index, otio_get<otio::Composable>(child), &err);
    otio_check(err);
}

// [[Rcpp::export]]
void cpp_remove_child(SEXP x, int index) {
    otio::ErrorStatus err;
    otio_get<otio::Composition>(x)->remove_child(index, &err);
    otio_check(err);
}

// [[Rcpp::export]]
void cpp_clear_children(SEXP x) {
    otio_get<otio::Composition>(x)->clear_children();
}

// [[Rcpp::export]]
void cpp_set_children(SEXP x, Rcpp::List children) {
    std::vector<otio::Composable*> kids;
    kids.reserve(children.size());
    for (R_xlen_t i = 0; i < children.size(); ++i)
        kids.push_back(otio_get<otio::Composable>(children[i]));
    otio::ErrorStatus err;
    otio_get<otio::Composition>(x)->set_children(kids, &err);
    otio_check(err);
}

// Returns the 0-based index, or -1 if not a child.
// [[Rcpp::export]]
int cpp_index_of_child(SEXP x, SEXP child) {
    otio::ErrorStatus err;
    int idx = otio_get<otio::Composition>(x)->index_of_child(
        otio_get<otio::Composable>(child), &err);
    if (err.outcome != otio::ErrorStatus::OK) return -1;
    return idx;
}

// [[Rcpp::export]]
bool cpp_is_parent_of(SEXP x, SEXP other) {
    return otio_get<otio::Composition>(x)->is_parent_of(otio_get<otio::Composable>(other));
}

// [[Rcpp::export]]
bool cpp_has_child(SEXP x, SEXP child) {
    return otio_get<otio::Composition>(x)->has_child(otio_get<otio::Composable>(child));
}

// [[Rcpp::export]]
bool cpp_has_clips(SEXP x) {
    return otio_get<otio::Composition>(x)->has_clips();
}

// [[Rcpp::export]]
Rcpp::List cpp_find_clips(SEXP x) {
    otio::Composition* comp = otio_get<otio::Composition>(x);
    otio::ErrorStatus err;
    auto clips = comp->find_clips(&err);
    otio_check(err);
    std::vector<otio::Clip*> out;
    for (auto const& r : clips) out.push_back(r.value);
    return otio_xptr_list(out);
}

// SerializableCollection has its own find_clips (it is not a Composition).
// [[Rcpp::export]]
Rcpp::List cpp_collection_find_clips(SEXP x) {
    otio::SerializableCollection* coll = otio_get<otio::SerializableCollection>(x);
    otio::ErrorStatus err;
    auto clips = coll->find_clips(&err);
    otio_check(err);
    std::vector<otio::Clip*> out;
    for (auto const& r : clips) out.push_back(r.value);
    return otio_xptr_list(out);
}
