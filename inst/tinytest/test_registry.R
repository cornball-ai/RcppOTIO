library(rotio)

## type_version_map: registered schemas and their current versions
tvm <- type_version_map()
expect_true(is.integer(tvm))
expect_true(all(c("Clip", "Marker", "Timeline", "Gap") %in% names(tvm)))
expect_true(tvm[["Clip"]] >= 2L)      # Clip is schema version 2
expect_true(tvm[["Marker"]] >= 2L)
expect_true(tvm[["Timeline"]] >= 1L)

## registration return semantics
## - a fresh (schema, version) slot registers TRUE
## - the same slot again returns FALSE
## - an unregistered schema returns FALSE
expect_true(register_downgrade_function("Gap", 2, function(d) d))
expect_false(register_downgrade_function("Gap", 2, function(d) d))
expect_false(register_downgrade_function("NoSuchSchemaXYZ", 2, function(d) d))

expect_true(register_upgrade_function("Timeline", 2, function(d) d))
expect_false(register_upgrade_function("Timeline", 2, function(d) d))
expect_false(register_upgrade_function("NoSuchSchemaXYZ", 2, function(d) d))

## the downgrade callback is actually invoked with the schema dict and its
## result is used: register one that tags the metadata, serialize a Marker
## with a target version of 1, and confirm both the version relabel and our
## mutation appear in the output.
ok <- register_downgrade_function("Marker", 2, function(d) {
    d$metadata$rotio_tag <- "downgraded"
    d
})
expect_true(ok)
m <- Marker("m", marked_range = TimeRange(RationalTime(0, 24), RationalTime(1, 24)))
js <- to_json_string(m, target_schema_versions = c(Marker = 1L))
expect_true(grepl("Marker.1", js, fixed = TRUE))      # relabelled to v1
expect_true(grepl("rotio_tag", js, fixed = TRUE))      # our callback ran

## a serialize target map drives a real downgrade end-to-end: OTIO's own
## Clip 2->1 downgrade produces valid v1 JSON that reloads (and upgrades
## back) to an equivalent object.
clip <- Clip("c", media_reference = ExternalReference("a.mov"),
             source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
js2 <- to_json_string(clip, target_schema_versions = c(Clip = 1L))
expect_true(grepl("Clip.1", js2, fixed = TRUE))
clip2 <- from_json_string(js2)
expect_equal(schema_version(clip2), 2L)                # upgraded back on read
expect_true(is_equivalent_to(clip, clip2))

## target_schema_versions is validated strictly before reaching OTIO:
## must be named, whole-number, non-NA, non-duplicate, non-character.
expect_error(to_json_string(m, target_schema_versions = 1L), "named")
expect_error(to_json_string(m, target_schema_versions = c(Clip = NA_integer_)), "NA")
expect_error(to_json_string(m, target_schema_versions = c(Clip = 1.9)), "whole")
expect_error(to_json_string(m, target_schema_versions = c(Clip = "1")), "whole")
expect_error(to_json_string(m, target_schema_versions = c(Clip = 1L, Clip = 2L)), "duplicate")
## a clean whole-number double is accepted (coerced to integer)
expect_true(is.character(to_json_string(m, target_schema_versions = c(Marker = 1))))

## const char* metadata values survive the AnyDictionary -> R conversion
## (OTIO can store C-string literals; they must not be dropped). Exercised
## via the downgrade dict round-trip above without warnings.
