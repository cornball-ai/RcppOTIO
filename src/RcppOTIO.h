#ifndef RCPPOTIO_H
#define RCPPOTIO_H

// Umbrella header: OTIO includes, namespace aliases, and the shared
// helper layer (error handling, external-pointer ownership, time-type
// and metadata conversions). Every .cpp in this package includes this.

#include <Rcpp.h>

#include <opentimelineio/timeline.h>
#include <opentimelineio/stack.h>
#include <opentimelineio/track.h>
#include <opentimelineio/clip.h>
#include <opentimelineio/gap.h>
#include <opentimelineio/transition.h>
#include <opentimelineio/marker.h>
#include <opentimelineio/effect.h>
#include <opentimelineio/timeEffect.h>
#include <opentimelineio/linearTimeWarp.h>
#include <opentimelineio/freezeFrame.h>
#include <opentimelineio/mediaReference.h>
#include <opentimelineio/externalReference.h>
#include <opentimelineio/imageSequenceReference.h>
#include <opentimelineio/generatorReference.h>
#include <opentimelineio/missingReference.h>
#include <opentimelineio/serializableCollection.h>
#include <opentimelineio/serializableObjectWithMetadata.h>
#include <opentimelineio/anyDictionary.h>
#include <opentimelineio/anyVector.h>
#include <opentimelineio/safely_typed_any.h>
#include <opentimelineio/errorStatus.h>

#include <opentime/rationalTime.h>
#include <opentime/timeRange.h>
#include <opentime/timeTransform.h>

// OTIO_NS is defined by opentimelineio/version.h as
// opentimelineio::OPENTIMELINEIO_VERSION. opentime types resolve through
// opentime's `using namespace OPENTIME_VERSION`.
namespace otio = OTIO_NS;
namespace ot = opentime;

#include "otio_error.h"
#include "otio_xptr.h"
#include "otio_time.h"
#include "otio_metadata.h"

#endif // RCPPOTIO_H
