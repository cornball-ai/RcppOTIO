#ifndef ROTIO_OTIO_METADATA_H
#define ROTIO_OTIO_METADATA_H

// AnyDictionary <-> R named list conversion. AnyDictionary is a
// std::map<std::string, std::any>; we store/read entries individually and
// map the OTIO scalar / time / object / list / dict types we can
// represent faithfully in base R. Exotic std::any payloads we cannot
// represent are dropped with a warning on read (JSON round-trips go
// through OTIO directly and stay lossless regardless).

#include <Rcpp.h>
#include <any>
#include <opentimelineio/anyDictionary.h>
#include <opentimelineio/anyVector.h>

std::any         r_to_any(SEXP x);
SEXP             any_to_r(std::any const& a);
otio::AnyDictionary as_any_dictionary(SEXP x);   // R named list -> dict
SEXP             wrap_any_dictionary(otio::AnyDictionary const& d);

#endif // ROTIO_OTIO_METADATA_H
