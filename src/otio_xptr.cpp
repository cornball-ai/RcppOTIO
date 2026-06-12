#include "RcppOTIO.h"

// Build the S3 class chain for an object, most-derived first, ending in
// "otio". dynamic_cast order matters: test leaves before their bases.
std::vector<std::string> otio_class_chain(otio::SerializableObject* obj) {
    std::vector<std::string> c;
    if      (dynamic_cast<otio::Timeline*>(obj))
        c = {"Timeline", "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::Stack*>(obj))
        c = {"Stack", "Composition", "Item", "Composable",
             "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::Track*>(obj))
        c = {"Track", "Composition", "Item", "Composable",
             "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::Clip*>(obj))
        c = {"Clip", "Item", "Composable",
             "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::Gap*>(obj))
        c = {"Gap", "Item", "Composable",
             "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::Transition*>(obj))
        c = {"Transition", "Composable",
             "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::Marker*>(obj))
        c = {"Marker", "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::FreezeFrame*>(obj))
        c = {"FreezeFrame", "LinearTimeWarp", "TimeEffect", "Effect",
             "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::LinearTimeWarp*>(obj))
        c = {"LinearTimeWarp", "TimeEffect", "Effect",
             "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::TimeEffect*>(obj))
        c = {"TimeEffect", "Effect",
             "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::Effect*>(obj))
        c = {"Effect", "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::ExternalReference*>(obj))
        c = {"ExternalReference", "MediaReference",
             "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::ImageSequenceReference*>(obj))
        c = {"ImageSequenceReference", "MediaReference",
             "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::GeneratorReference*>(obj))
        c = {"GeneratorReference", "MediaReference",
             "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::MissingReference*>(obj))
        c = {"MissingReference", "MediaReference",
             "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::MediaReference*>(obj))
        c = {"MediaReference", "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::SerializableCollection*>(obj))
        c = {"SerializableCollection", "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::Composition*>(obj))
        c = {"Composition", "Item", "Composable",
             "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::Item*>(obj))
        c = {"Item", "Composable",
             "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::Composable*>(obj))
        c = {"Composable", "SerializableObjectWithMetadata", "SerializableObject"};
    else if (dynamic_cast<otio::SerializableObjectWithMetadata*>(obj))
        c = {"SerializableObjectWithMetadata", "SerializableObject"};
    else
        c = {"SerializableObject"};
    c.push_back("otio");
    return c;
}
