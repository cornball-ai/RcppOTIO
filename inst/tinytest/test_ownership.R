library(RcppOTIO)

## A child fetched from a parent must stay alive independently of the
## original R handle and of garbage collection, because OTIO's intrusive
## ref-counting keeps it retained by both the parent and the new handle.

build <- function() {
    tl <- Timeline("t")
    trk <- Track("V1", "Video")
    append_child(trk, Clip("buried", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24))))
    append_child(tracks(tl), trk)
    tl
}

tl <- build()            # the intermediate trk/clip handles are now gone
gc(); gc()               # force collection of those dropped handles

## The buried clip is still reachable through the tree and usable.
clips <- find_clips(tl)
expect_equal(length(clips), 1L)
expect_equal(name(clips[[1]]), "buried")
expect_equal(to_seconds(duration(clips[[1]])), 1)

## Fetch a child, drop every other reference to the tree, GC, still valid.
child <- children(tracks(tl))[[1]]
rm(tl); gc(); gc()
expect_equal(name(child), "V1")
expect_equal(length(children(child)), 1L)

## Round-tripping under GC pressure (many short-lived time values).
tl2 <- build()
for (i in 1:200) {
    invisible(RationalTime(i, 24) + RationalTime(1, 24))
    if (i %% 50 == 0) gc()
}
expect_equal(length(find_clips(tl2)), 1L)
expect_true(is_equivalent_to(tl2, from_json_string(to_json_string(tl2))))
