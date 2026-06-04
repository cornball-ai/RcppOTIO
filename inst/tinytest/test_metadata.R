library(rotio)

clip <- Clip("c")

## empty metadata by default
expect_equal(length(metadata(clip)), 0L)

## scalar types round-trip through AnyDictionary
metadata(clip) <- list(fps = 24, source = "camera1", good = TRUE, take = 3L)
md <- metadata(clip)
expect_equal(md$fps, 24)
expect_equal(md$source, "camera1")
expect_true(md$good)
expect_equal(md$take, 3)

## nested named list -> sub-dictionary; time types preserved
metadata(clip) <- list(cam = list(make = "ARRI", iso = 800),
                       mark = RationalTime(12, 24))
md <- metadata(clip)
expect_equal(md$cam$make, "ARRI")
expect_equal(md$cam$iso, 800)
expect_inherits(md$mark, "RationalTime")
expect_equal(value(md$mark), 12)

## metadata survives JSON round-trip (handled by OTIO, not the R layer)
metadata(clip) <- list(scene = "12A", fps = 23.976)
clip2 <- from_json_string(to_json_string(clip))
md2 <- metadata(clip2)
expect_equal(md2$scene, "12A")
expect_equal(md2$fps, 23.976)
