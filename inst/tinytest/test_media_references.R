library(rotio)

## A clip can hold several media references under string keys, one active.
proxy <- ExternalReference("proxy.mov",
                           available_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
full  <- ExternalReference("full.mov",
                           available_range = TimeRange(RationalTime(0, 24), RationalTime(96, 24)))

clip <- Clip("shot")
set_media_references(clip, list(proxy = proxy, full = full), new_active_key = "full")

refs <- media_references(clip)
expect_equal(sort(names(refs)), c("full", "proxy"))
expect_inherits(refs[["proxy"]], "ExternalReference")
expect_equal(target_url(refs[["proxy"]]), "proxy.mov")

## the active key selects which reference media_reference() returns
expect_equal(active_media_reference_key(clip), "full")
expect_equal(target_url(media_reference(clip)), "full.mov")

active_media_reference_key(clip) <- "proxy"
expect_equal(target_url(media_reference(clip)), "proxy.mov")

## validation: active key must exist; keys must be non-empty
expect_error(set_media_references(clip, list(a = proxy), "nope"))
expect_error(set_media_references(clip, setNames(list(proxy), ""), ""))

## a named list is required when non-empty
expect_error(set_media_references(clip, list(proxy), "1"),
             "named list")

## malformed R keys are rejected rather than silently coerced/collapsed
expect_error(set_media_references(clip, setNames(list(proxy), NA_character_), "x"), "NA")
expect_error(set_media_references(clip, list(k = proxy, k = full), "k"), "duplicate")
expect_error(set_media_references(clip, list(a = proxy), NA_character_), "non-NA")
expect_error(set_media_references(clip, list(a = proxy), c("a", "b")), "single")

## JSON round-trip preserves the whole map and the active key
clip2 <- from_json_string(to_json_string(clip))
expect_equal(sort(names(media_references(clip2))), c("full", "proxy"))
expect_equal(active_media_reference_key(clip2), "proxy")
expect_equal(target_url(media_reference(clip2)), "proxy.mov")

## the single-reference constructor path stays consistent with the map
solo <- Clip("solo", media_reference = ExternalReference("solo.mov"))
expect_equal(names(media_references(solo)), default_media_key())
expect_equal(target_url(media_references(solo)[[default_media_key()]]), "solo.mov")
