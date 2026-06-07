library(RcppOTIO)

# Expected values below were verified against OTIO 0.18.1 behavior, not
# assumed from the header diagrams.

mkclip <- function(nm, frames) {
    Clip(nm, source_range = TimeRange(RationalTime(0, 24), RationalTime(frames, 24)))
}
trk    <- function() Track("V1", "Video")
cnames <- function(t) vapply(children(t), name, character(1))
cdurs  <- function(t) vapply(children(t), function(k) value(duration(k)), numeric(1))
cclass <- function(t) vapply(children(t), function(k) class(k)[1], character(1))

## ---- slice: |A| -> |A|A| ----
t <- trk(); append_child(t, mkclip("A", 48)); append_child(t, mkclip("B", 48))
slice(t, RationalTime(24, 24))
expect_equal(cnames(t), c("A", "A", "B"))
expect_equal(cdurs(t), c(24, 24, 48))

## ---- insert: splits A and drops C in ----
t <- trk(); append_child(t, mkclip("A", 48))
insert(mkclip("C", 24), t, RationalTime(24, 24))
expect_equal(cnames(t), c("A", "C", "A"))
expect_equal(cdurs(t), c(24, 24, 24))

## ---- overwrite: |A|B| with C over [24,48) -> |A|C|B| ----
t <- trk(); append_child(t, mkclip("A", 48)); append_child(t, mkclip("B", 48))
overwrite(mkclip("C", 24), t, TimeRange(RationalTime(24, 24), RationalTime(24, 24)))
expect_equal(cnames(t), c("A", "C", "B"))
expect_equal(cdurs(t), c(24, 24, 48))

## ---- remove with fill=TRUE leaves a correctly-sized gap (nullptr template) ----
t <- trk()
append_child(t, mkclip("A", 24)); append_child(t, mkclip("B", 24)); append_child(t, mkclip("D", 24))
remove(t, RationalTime(36, 24))                 # the middle clip (1.0-1.5s)
expect_equal(cclass(t), c("Clip", "Gap", "Clip"))
expect_equal(cnames(t)[c(1, 3)], c("A", "D"))
expect_equal(cdurs(t), c(24, 24, 24))           # gap sized to the removed clip

## ---- remove with fill=FALSE concatenates ----
t <- trk()
append_child(t, mkclip("A", 24)); append_child(t, mkclip("B", 24)); append_child(t, mkclip("D", 24))
remove(t, RationalTime(36, 24), fill = FALSE)
expect_equal(cnames(t), c("A", "D"))
expect_equal(length(children(t)), 2L)

## ---- trim: B in-point +12; previous clip absorbs, B shrinks ----
t <- trk()
append_child(t, mkclip("A", 48)); append_child(t, mkclip("B", 48)); append_child(t, mkclip("C", 48))
trim(children(t)[[2]], RationalTime(12, 24), RationalTime(0, 24))
expect_equal(cdurs(t), c(60, 36, 48))

## ---- ripple: shorten A's out by 12; B keeps duration, shifts earlier ----
t <- trk(); append_child(t, mkclip("A", 48)); append_child(t, mkclip("B", 48))
ripple(children(t)[[1]], RationalTime(0, 24), RationalTime(-12, 24))
expect_equal(cdurs(t), c(36, 48))
expect_equal(value(end_time_exclusive(range_in_parent(children(t)[[1]]))), 36)

## ---- roll: extend A's out by 12; B duration unchanged ----
t <- trk(); append_child(t, mkclip("A", 48)); append_child(t, mkclip("B", 48))
roll(children(t)[[1]], RationalTime(0, 24), RationalTime(12, 24))
expect_equal(cdurs(t), c(60, 48))

## ---- slide: move B start +12; previous clip A grows ----
t <- trk()
append_child(t, mkclip("A", 48)); append_child(t, mkclip("B", 48)); append_child(t, mkclip("C", 48))
slide(children(t)[[2]], RationalTime(12, 24))
expect_equal(cdurs(t), c(60, 48, 48))

## ---- slip: shift source in/out, keep duration and position ----
cl <- Clip("A",
           ExternalReference("a.mov",
                             available_range = TimeRange(RationalTime(0, 24), RationalTime(96, 24))),
           source_range = TimeRange(RationalTime(24, 24), RationalTime(24, 24)))
t <- trk(); append_child(t, cl)
slip(cl, RationalTime(-12, 24))
expect_equal(value(start_time(source_range(cl))), 12)
expect_equal(value(duration(cl)), 24)           # duration unchanged

## ---- fill: drop C into an existing gap ----
t <- trk()
append_child(t, mkclip("A", 24)); append_child(t, Gap(RationalTime(24, 24))); append_child(t, mkclip("B", 24))
fill(mkclip("C", 24), t, RationalTime(24, 24), "Source")
expect_equal(cclass(t), c("Clip", "Clip", "Clip"))
expect_equal(cnames(t), c("A", "C", "B"))
expect_error(fill(mkclip("X", 1), t, RationalTime(0, 24), "Nonsense"), "reference_point")

## ---- track_trimmed_to_range returns a new, trimmed track ----
t <- trk(); append_child(t, mkclip("A", 48)); append_child(t, mkclip("B", 48))
tt <- track_trimmed_to_range(t, TimeRange(RationalTime(24, 24), RationalTime(48, 24)))
expect_inherits(tt, "Track")
expect_equal(cdurs(tt), c(24, 24))              # new track trimmed
expect_equal(cdurs(t), c(48, 48))               # original untouched

## ---- flatten_stack: top track wins, bottom shows through ----
st <- Stack("root")
t1 <- trk(); append_child(t1, mkclip("bottom", 48))
t2 <- trk(); append_child(t2, mkclip("top", 24))
append_child(st, t1); append_child(st, t2)
ft <- flatten_stack(st)
expect_inherits(ft, "Track")
expect_equal(cnames(ft), c("top", "bottom"))
expect_equal(cdurs(ft), c(24, 24))

## flatten a list of tracks too
ft2 <- flatten_stack(list(t1, t2))
expect_inherits(ft2, "Track")
expect_equal(cnames(ft2), c("top", "bottom"))
