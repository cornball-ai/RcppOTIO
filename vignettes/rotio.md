<!--
%\VignetteEngine{simplermarkdown::mdweave_to_html}
%\VignetteIndexEntry{Getting started with rotio}
-->
---
title: "Getting started with rotio"
---

`rotio` is an R binding for [OpenTimelineIO](https://github.com/AcademySoftwareFoundation/OpenTimelineIO)
(OTIO), the editorial timeline interchange format. It wraps the OTIO C++
library with Rcpp, so you build and edit real OTIO objects from R and read
or write `.otio` JSON that other tools understand.

Two kinds of thing live in `rotio`:

- **Time values** (`RationalTime`, `TimeRange`, `TimeTransform`) are plain
  classed R values. They print, compare, and copy like ordinary R objects.
- **Schema objects** (`Timeline`, `Track`, `Clip`, ...) are handles to
  reference-counted C++ objects, addressed by position and reference
  rather than by name.

Names follow OTIO exactly, so `source_range`, `range_in_parent`, and
`append_child` mean what they do in the OTIO docs.

``` {.R}
library(rotio)
```

## Time

A `RationalTime` is a value at a sample rate, e.g. a frame count at a frame
rate. A `TimeRange` is a start time plus a duration.

``` {.R}
rt <- RationalTime(48, 24)   # 48 frames at 24 fps
to_seconds(rt)
to_timecode(rt, 24)

tr <- TimeRange(RationalTime(0, 24), RationalTime(48, 24))
to_seconds(duration(tr))
to_seconds(end_time_exclusive(tr))
```

Times are values, so arithmetic and comparison work directly:

``` {.R}
RationalTime(10, 24) + RationalTime(5, 24)
RationalTime(10, 24) < RationalTime(20, 24)
```

## Building a timeline

A `Timeline` owns a `Stack` of tracks (reached with `tracks()`); a `Track`
holds a sequence of clips. A `Clip` points at a media reference and carries
a `source_range`, the trimmed slice of media it shows.

``` {.R}
tl  <- Timeline("my timeline")
trk <- Track("V1", kind = "Video")

clipA <- Clip("A",
              ExternalReference("a.mov",
                                available_range = TimeRange(RationalTime(0, 24),
                                                            RationalTime(240, 24))),
              source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
clipB <- Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))

append_child(trk, clipA)
append_child(trk, clipB)
append_child(tracks(tl), trk)

length(find_clips(tl))
to_seconds(duration(tl))
```

A clip's position is not stored separately; it is `range_in_parent()`,
derived from the clips before it. `clipB` sits right after `clipA`:

``` {.R}
to_seconds(start_time(range_in_parent(clipB)))
```

Tree children are addressed by index (1-based) and by object reference,
never by name (siblings may share a name):

``` {.R}
index_of_child(trk, clipB)
name(children(trk)[[1]])
```

## Media references

A clip can carry several media references under string keys (say a proxy
and a full-res master) with one marked active.

``` {.R}
proxy  <- ExternalReference("proxy.mov")
master <- ExternalReference("master.mov")
clip   <- Clip("shot")
set_media_references(clip, list(proxy = proxy, master = master),
                     new_active_key = "master")

names(media_references(clip))
active_media_reference_key(clip)
target_url(media_reference(clip))
```

## Editing

The OTIO edit algorithms mutate a track in place. Here we slice a clip in
two, then overwrite part of a track with a new clip.

``` {.R}
edit <- Track("V1", kind = "Video")
append_child(edit, Clip("A", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))
append_child(edit, Clip("B", source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24))))

slice(edit, RationalTime(24, 24))
vapply(children(edit), name, character(1))

over <- Clip("C", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24)))
overwrite(over, edit, TimeRange(RationalTime(24, 24), RationalTime(24, 24)))
vapply(children(edit), name, character(1))
```

`rotio` also wraps `insert`, `trim`, `slip`, `slide`, `ripple`, `roll`,
`fill`, `remove`, plus `track_trimmed_to_range` and `flatten_stack`.

## JSON round-trips

Read and write OTIO JSON. The round-trip is lossless: the reloaded object
is equivalent to the original.

``` {.R}
js  <- to_json_string(tl)
tl2 <- from_json_string(js)
is_equivalent_to(tl, tl2)

f <- tempfile(fileext = ".otio")
to_json_file(tl, f)
identical(schema_name(from_json_file(f)), "Timeline")
unlink(f)
```

## Schema versioning

OTIO schemas are versioned. `type_version_map()` reports the registered
versions, and `to_json_string()` can downgrade on write to an older
version using the registered downgrade functions.

``` {.R}
tvm <- type_version_map()
tvm[["Clip"]]

clip <- Clip("c", media_reference = ExternalReference("a.mov"))
older <- to_json_string(clip, target_schema_versions = c(Clip = 1L))
grepl("Clip.1", older, fixed = TRUE)
```

You can register your own upgrade/downgrade functions; each receives the
schema dictionary as a named list and returns the modified list. See
`?register_upgrade_function`.
