# rotio

R bindings for [OpenTimelineIO](https://opentimeline.io) (OTIO), built as
an Rcpp wrapper over the OTIO C++ library (0.18.x).

It covers the time types, the schema classes, tree construction, JSON
round-trips, and the edit algorithms (`overwrite`, `insert`, `trim`,
`slice`, `slip`, `slide`, `ripple`, `roll`, `fill`, `remove`) plus
`track_trimmed_to_range` and `flatten_stack`. Still not wrapped: the full
`media_references` map and the `TypeRegistry` schema-upgrade hooks.

## Design

- **Value types are plain classed R values.** `RationalTime`,
  `TimeRange`, and `TimeTransform` are immutable values, so they live as
  classed R objects (a named numeric for `RationalTime`, small lists for
  the others) and convert to/from C++ only at the call boundary. They
  print, compare, and serialize naturally in R.
- **Schema objects are external pointers with OTIO's ref-counting.**
  `Timeline`, `Stack`, `Track`, `Clip`, and the rest are `SerializableObject`s
  with object identity, parentage, and intrusive reference counting. Each R
  handle holds a heap `Retainer<SerializableObject>` inside an external
  pointer; the object self-deletes only when the last reference (R handle
  or tree parent) goes away. You never `delete` one directly.
- **Names follow OTIO exactly.** `source_range`, `range_in_parent`,
  `append_child`, `media_reference`, and so on, with `field<-` setters
  where OTIO has a setter. No invented aliases.
- **Addressing is by position and reference, never by name.** A `name` is
  a label; sibling items may share one. Tree children are addressed by
  1-based position (translated to OTIO's 0-based index at the boundary)
  and by object reference.

## Example

```r
library(rotio)

tl   <- Timeline("my timeline")
trk  <- Track("V1", kind = "Video")
clip <- Clip("shot",
             ExternalReference("shot.mov"),
             source_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))

append_child(trk, clip)
append_child(tracks(tl), trk)

duration(tl)                       # RationalTime(value = 48, rate = 24)
range_in_parent(clip)              # where the clip sits in the track
find_clips(tl)                     # list of clips, recursively

js  <- to_json_string(tl)          # OTIO JSON
tl2 <- from_json_string(js)
is_equivalent_to(tl, tl2)          # TRUE
```

## Requirements

The OpenTimelineIO C++ library and Imath headers must be installed
(default `/usr/local`). Override at install time with:

```sh
R CMD INSTALL --configure-vars='OTIO_HOME=/opt/otio' rotio
```
