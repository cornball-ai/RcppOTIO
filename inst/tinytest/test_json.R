library(rotio)

## Build a small timeline
tl <- Timeline("show")
trk <- Track("V1", kind = "Video")
clip <- Clip("shot",
             ExternalReference("shot.mov",
                               available_range = TimeRange(RationalTime(0, 24), RationalTime(240, 24))),
             source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
append_child(trk, clip)
append_child(tracks(tl), trk)

## to_json_string / from_json_string round-trip preserves equivalence
js <- to_json_string(tl)
expect_true(is.character(js))
expect_true(grepl("Timeline.1", js, fixed = TRUE))

tl2 <- from_json_string(js)
expect_inherits(tl2, "Timeline")
expect_true(is_equivalent_to(tl, tl2))
expect_equal(length(find_clips(tl2)), 1L)
expect_equal(name(find_clips(tl2)[[1]]), "shot")

## file round-trip
f <- tempfile(fileext = ".otio")
to_json_file(tl, f)
expect_true(file.exists(f))
tl3 <- from_json_file(f)
expect_true(is_equivalent_to(tl, tl3))
unlink(f)

## clone is independent
cl <- clone(clip)
name(cl) <- "copy"
expect_equal(name(clip), "shot")
expect_equal(name(cl), "copy")
expect_false(is_equivalent_to(clip, cl))
