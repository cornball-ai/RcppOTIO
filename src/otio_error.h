#ifndef ROTIO_OTIO_ERROR_H
#define ROTIO_OTIO_ERROR_H

// Translate an OTIO ErrorStatus into an R error. OTIO functions take an
// optional ErrorStatus* out-parameter; outcome == OK means success. We
// raise on anything else, using full_description (outcome + details).
//
// opentime and opentimelineio define separate ErrorStatus types with the
// same shape (an Outcome enum with OK, plus full_description), so this is
// a template that accepts either.

#include <Rcpp.h>

template <typename ErrorStatusT>
inline void otio_check(ErrorStatusT const& err) {
    if (err.outcome != ErrorStatusT::OK) {
        Rcpp::stop(err.details);
    }
}

#endif // ROTIO_OTIO_ERROR_H
