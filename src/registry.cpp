#include "rotio.h"
#include <opentimelineio/typeRegistry.h>
#include <functional>

using namespace Rcpp;

// TypeRegistry schema upgrade/downgrade hooks.
//
// OTIO upgrade/downgrade functions are C++ callbacks of type
// void(AnyDictionary*): they receive the raw schema dictionary and mutate
// it in place. We bridge an R function with the signature
// `function(dict) -> dict`: it is handed the schema as a named list and
// must return the (possibly modified) named list.
//
// Upgrade functions run during deserialization when an object's stored
// schema version is older than the registered version. Downgrade
// functions run during serialization when a target schema version map is
// supplied (see to_json_string(target_schema_versions = ...)).
//
// The TypeRegistry is a process-global singleton with no unregister API,
// so a registered R function must outlive any R garbage collection. We
// R_PreserveObject it for the rest of the session. Registrations are few
// and deliberate, so this bounded retention is acceptable.

static std::function<void(otio::AnyDictionary*)> make_dict_callback(Rcpp::Function fn) {
    SEXP s = fn;
    R_PreserveObject(s);
    return [s](otio::AnyDictionary* d) {
        Rcpp::Function f(s);
        SEXP res = f(wrap_any_dictionary(*d));
        if (TYPEOF(res) != VECSXP)
            Rcpp::stop("a schema upgrade/downgrade function must return a named list");
        *d = as_any_dictionary(res);
    };
}

// Returns FALSE if a function is already registered for this
// (schema_name, version) pair, or if schema_name is not a registered
// schema; TRUE otherwise.
// [[Rcpp::export]]
bool cpp_register_upgrade_function(std::string schema_name, int version_to_upgrade_to,
                                   Rcpp::Function fn) {
    return otio::TypeRegistry::instance().register_upgrade_function(
        schema_name, version_to_upgrade_to, make_dict_callback(fn));
}

// Downgrades from version_to_downgrade_from to version_to_downgrade_from - 1.
// [[Rcpp::export]]
bool cpp_register_downgrade_function(std::string schema_name, int version_to_downgrade_from,
                                     Rcpp::Function fn) {
    return otio::TypeRegistry::instance().register_downgrade_function(
        schema_name, version_to_downgrade_from, make_dict_callback(fn));
}

// Map of registered schema name -> current version.
// [[Rcpp::export]]
SEXP cpp_type_version_map() {
    otio::schema_version_map m;
    otio::TypeRegistry::instance().type_version_map(m);
    Rcpp::IntegerVector out(m.size());
    Rcpp::CharacterVector nms(m.size());
    R_xlen_t i = 0;
    for (auto const& kv : m) {
        nms[i] = kv.first;
        out[i] = static_cast<int>(kv.second);
        ++i;
    }
    out.names() = nms;
    return out;
}
