library(RcppOTIO)

## RationalTime construction and accessors
rt <- RationalTime(24, 24)
expect_inherits(rt, "RationalTime")
expect_equal(value(rt), 24)
expect_equal(rate(rt), 24)
expect_equal(to_seconds(rt), 1)
expect_equal(to_frames(RationalTime(48, 24)), 48L)

## from_* builders
expect_equal(to_seconds(from_seconds(2, 24)), 2)
expect_equal(value(from_frames(10, 24)), 10)

## rescale
expect_equal(value(rescaled_to(RationalTime(24, 24), 48)), 48)

## SMPTE timecode round-trip
expect_equal(to_timecode(RationalTime(48, 24), 24), "00:00:02:00")
expect_equal(value(from_timecode("00:00:02:00", 24)), 48)

## no-rate overload: uses the RationalTime's own rate + infers drop-frame
expect_equal(to_timecode(RationalTime(48, 24)), "00:00:02:00")
expect_equal(to_timecode(RationalTime(17982, 30000 / 1001)), "00:10:00;00")

## arithmetic and comparison (Ops)
expect_equal(value(RationalTime(10, 24) + RationalTime(5, 24)), 15)
expect_equal(value(RationalTime(10, 24) - RationalTime(4, 24)), 6)
expect_true(RationalTime(10, 24) < RationalTime(20, 24))
expect_true(RationalTime(10, 24) == RationalTime(10, 24))
expect_true(RationalTime(10, 24) != RationalTime(11, 24))
expect_true(almost_equal(RationalTime(10, 24), RationalTime(10, 24)))

## TimeRange
tr <- TimeRange(RationalTime(0, 24), RationalTime(48, 24))
expect_inherits(tr, "TimeRange")
expect_equal(to_seconds(start_time(tr)), 0)
expect_equal(to_seconds(duration(tr)), 2)
expect_equal(to_seconds(end_time_exclusive(tr)), 2)
expect_true(contains(tr, RationalTime(24, 24)))
expect_false(contains(tr, RationalTime(48, 24)))     # exclusive end
## contains(TimeRange) is strict at both edges in OTIO: a range sharing the
## start boundary is NOT contained, but a strictly-interior one is.
expect_false(contains(tr, TimeRange(RationalTime(0, 24), RationalTime(24, 24))))
expect_true(contains(tr, TimeRange(RationalTime(12, 24), RationalTime(24, 24))))

tr2 <- TimeRange(RationalTime(24, 24), RationalTime(48, 24))
expect_true(overlaps(tr, tr2))
expect_true(intersects(tr, tr2))

## range_from_start_end_time
r3 <- range_from_start_end_time(RationalTime(0, 24), RationalTime(48, 24))
expect_equal(to_seconds(duration(r3)), 2)

## Malformed value-type input is rejected at the C++ boundary with a
## clear error rather than producing garbage.
expect_error(to_seconds(structure(c(foo = 1), class = "RationalTime")), "RationalTime")
expect_error(to_seconds(list(a = 1)), "RationalTime")
expect_error(end_time_exclusive(list(start_time = RationalTime(0, 24))), "TimeRange")

## TimeTransform
tt <- TimeTransform(RationalTime(0, 24), scale = 2, rate = 24)
expect_inherits(tt, "TimeTransform")
expect_equal(tt$scale, 2)
expect_equal(rate(tt), 24)
