library(rotio)

## Construction and schema identity
tl <- Timeline("my timeline")
expect_inherits(tl, "Timeline")
expect_inherits(tl, "otio")
expect_equal(schema_name(tl), "Timeline")
expect_equal(schema_version(tl), 1L)
expect_equal(name(tl), "my timeline")

## name setter; name is a label, not identity
name(tl) <- "renamed"
expect_equal(name(tl), "renamed")

## Track kind
trk <- Track("V1", kind = "Video")
expect_equal(kind(trk), "Video")
kind(trk) <- "Audio"
expect_equal(kind(trk), "Audio")
kind(trk) <- "Video"

## Clip + source_range
clipA <- Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
clipB <- Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(12, 24)))
expect_equal(to_seconds(duration(clipA)), 1)
expect_equal(to_seconds(duration(source_range(clipA))), 1)
source_range(clipA) <- TimeRange(RationalTime(0, 24), RationalTime(48, 24))
expect_equal(to_seconds(duration(clipA)), 2)
source_range(clipA) <- TimeRange(RationalTime(0, 24), RationalTime(24, 24))

## Tree building: append, index, children
append_child(trk, clipA)
append_child(trk, clipB)
append_child(tracks(tl), trk)
expect_equal(length(children(trk)), 2L)
expect_equal(index_of_child(trk, clipA), 1L)
expect_equal(index_of_child(trk, clipB), 2L)
expect_true(has_child(trk, clipA))
expect_true(has_clips(trk))
expect_true(is_parent_of(trk, clipA))

## Position is range_in_parent(), not a stored field. clipB sits after clipA.
expect_equal(to_seconds(start_time(range_in_parent(clipA))), 0)
expect_equal(to_seconds(start_time(range_in_parent(clipB))), 1)
expect_equal(to_seconds(duration(tl)), 1.5)

## parent() pointer
expect_equal(name(parent(clipA)), name(trk))

## Timeline track filtering and clip search
expect_equal(length(video_tracks(tl)), 1L)
expect_equal(length(audio_tracks(tl)), 0L)
expect_equal(length(find_clips(tl)), 2L)
expect_equal(length(find_clips(trk)), 2L)

## Names are not identity: siblings may share a name, lookup is by reference
name(clipB) <- "A"
expect_equal(name(children(trk)[[1]]), "A")
expect_equal(name(children(trk)[[2]]), "A")
expect_equal(index_of_child(trk, clipB), 2L)   # still found by object, not name

## insert / set / remove (1-based)
gap <- Gap(RationalTime(6, 24))
insert_child(trk, 2, gap)                       # between A and B
expect_equal(length(children(trk)), 3L)
expect_equal(index_of_child(trk, gap), 2L)
remove_child(trk, 2)
expect_equal(length(children(trk)), 2L)
expect_false(has_child(trk, gap))

## index_of_child returns NA for a non-child
expect_true(is.na(index_of_child(trk, Clip("orphan"))))

## Gap is not visible
expect_false(visible(Gap(RationalTime(6, 24))))
expect_true(visible(clipA))
