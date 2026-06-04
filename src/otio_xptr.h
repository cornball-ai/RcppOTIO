#ifndef ROTIO_OTIO_XPTR_H
#define ROTIO_OTIO_XPTR_H

// External-pointer ownership for OTIO SerializableObject subclasses.
//
// SerializableObject has a protected destructor and intrusive
// ref-counting: you never `delete` one. A Retainer<T> increments the
// count on construction and decrements on destruction; the object
// self-deletes when the count hits zero. So we heap-allocate a
// Retainer<SerializableObject> per R handle and store it in an XPtr.
// When R garbage-collects the handle, the default XPtr finalizer
// deletes the *retainer* (not the object), dropping one reference.
//
// Tree parents hold their own retainers on children, so an object
// fetched from a parent stays alive regardless of R GC order, and an
// object whose only reference is the R handle dies when collected.

#include <Rcpp.h>
#include <vector>
#include <string>
#include <opentimelineio/serializableObject.h>

typedef otio::SerializableObject::Retainer<otio::SerializableObject> OtioRetainer;

// S3 class chain (most-derived first), ending in "otio" so package-wide
// generics like print.otio dispatch. Built by dynamic_cast from the
// most-derived type down, mirroring the OTIO inheritance graph.
std::vector<std::string> otio_class_chain(otio::SerializableObject* obj);

// Wrap a raw OTIO object in an R external pointer. Returns R_NilValue for
// a null pointer (OTIO's std::optional/absent-object idiom maps to NULL).
inline SEXP otio_xptr(otio::SerializableObject* obj) {
    if (!obj) return R_NilValue;
    OtioRetainer* r = new OtioRetainer(obj);     // +1 reference
    Rcpp::XPtr<OtioRetainer> ptr(r, true);       // GC -> delete retainer -> -1
    ptr.attr("class") = Rcpp::wrap(otio_class_chain(obj));
    return ptr;
}

// Extract the underlying object, checking it is (or derives from) T.
template <typename T>
inline T* otio_get(SEXP x) {
    if (Rf_isNull(x)) Rcpp::stop("expected an OTIO object, got NULL");
    if (TYPEOF(x) != EXTPTRSXP) Rcpp::stop("not an OTIO external pointer");
    Rcpp::XPtr<OtioRetainer> ptr(x);
    OtioRetainer* r = ptr.get();
    if (!r || !r->value) Rcpp::stop("OTIO external pointer is null (object freed?)");
    T* obj = dynamic_cast<T*>(r->value);
    if (!obj) Rcpp::stop("OTIO object is not of the expected type");
    return obj;
}

// Wrap a vector of raw OTIO pointers as an R list of external pointers.
template <typename T>
inline Rcpp::List otio_xptr_list(std::vector<T*> const& objs) {
    Rcpp::List out(objs.size());
    for (size_t i = 0; i < objs.size(); ++i) out[i] = otio_xptr(objs[i]);
    return out;
}

#endif // ROTIO_OTIO_XPTR_H
