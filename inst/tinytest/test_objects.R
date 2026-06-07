library(RcppOTIO)

## ---- Media references: all four subtypes ----
ext <- ExternalReference("a.mov")
expect_inherits(ext, "ExternalReference")
expect_inherits(ext, "MediaReference")
expect_equal(target_url(ext), "a.mov")
target_url(ext) <- "b.mov"
expect_equal(target_url(ext), "b.mov")
expect_false(is_missing_reference(ext))

img <- ImageSequenceReference(target_url_base = "file:///seq/",
                              name_prefix = "frame.", name_suffix = ".exr",
                              start_frame = 1L, frame_step = 1L, rate = 24,
                              frame_zero_padding = 4L,
                              available_range = TimeRange(RationalTime(0, 24), RationalTime(48, 24)))
expect_inherits(img, "ImageSequenceReference")
expect_equal(target_url_base(img), "file:///seq/")
expect_equal(name_prefix(img), "frame.")
expect_equal(name_suffix(img), ".exr")
expect_equal(start_frame(img), 1L)
expect_equal(rate(img), 24)
expect_equal(number_of_images_in_sequence(img), 48L)
expect_equal(target_url_for_image_number(img, 1L), "file:///seq/frame.0001.exr")

gen <- GeneratorReference("bars", generator_kind = "SMPTEBars")
expect_inherits(gen, "GeneratorReference")
expect_equal(generator_kind(gen), "SMPTEBars")
parameters(gen) <- list(width = 1920, height = 1080)
expect_equal(parameters(gen)$width, 1920)

miss <- MissingReference("gone")
expect_inherits(miss, "MissingReference")
expect_true(is_missing_reference(miss))

## Clip media reference binding + active key
clip <- Clip("c", media_reference = ext)
expect_equal(target_url(media_reference(clip)), "b.mov")
expect_equal(active_media_reference_key(clip), default_media_key())
media_reference(clip) <- gen
expect_inherits(media_reference(clip), "GeneratorReference")

## ---- Transition ----
tx <- Transition("dissolve", transition_type = "SMPTE_Dissolve",
                 in_offset = RationalTime(12, 24), out_offset = RationalTime(12, 24))
expect_inherits(tx, "Transition")
expect_equal(transition_type(tx), "SMPTE_Dissolve")
expect_equal(value(in_offset(tx)), 12)
expect_true(overlapping(tx))
transition_type(tx) <- "Custom_Transition"
expect_equal(transition_type(tx), "Custom_Transition")

## Transition is a Composable, not an Item, but has its own range methods.
## Unparented: OTIO raises ("no parent"). Parented between clips: a TimeRange.
expect_error(range_in_parent(tx), "parent")
expect_error(trimmed_range_in_parent(tx), "parent")
trk_tx <- Track("V1", "Video")
append_child(trk_tx, Clip("a", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24))))
append_child(trk_tx, tx)
append_child(trk_tx, Clip("b", source_range = TimeRange(RationalTime(0, 24), RationalTime(24, 24))))
expect_inherits(range_in_parent(tx), "TimeRange")
expect_inherits(trimmed_range_in_parent(tx), "TimeRange")

## ---- Marker ----
mk <- Marker("m", marked_range = TimeRange(RationalTime(0, 24), RationalTime(1, 24)),
             color = "RED", comment = "look here")
expect_inherits(mk, "Marker")
expect_equal(color(mk), "RED")
expect_equal(comment(mk), "look here")
color(mk) <- "BLUE"
expect_equal(color(mk), "BLUE")

## ---- Effect / LinearTimeWarp ----
ltw <- LinearTimeWarp("speed", effect_name = "LinearTimeWarp", time_scalar = 2)
expect_inherits(ltw, "LinearTimeWarp")
expect_inherits(ltw, "Effect")
expect_equal(effect_name(ltw), "LinearTimeWarp")
expect_equal(time_scalar(ltw), 2)
time_scalar(ltw) <- 0.5
expect_equal(time_scalar(ltw), 0.5)
expect_true(enabled(ltw))
enabled(ltw) <- FALSE
expect_false(enabled(ltw))

ff <- FreezeFrame("freeze")
expect_inherits(ff, "FreezeFrame")
expect_inherits(ff, "LinearTimeWarp")

## ---- SerializableCollection ----
coll <- SerializableCollection("bin", children = list(Clip("x"), Clip("y")))
expect_inherits(coll, "SerializableCollection")
expect_equal(length(find_clips(coll)), 2L)
## children() works on a collection (which is not a Composition)
kids <- children(coll)
expect_equal(length(kids), 2L)
expect_equal(name(kids[[1]]), "x")
expect_equal(name(kids[[2]]), "y")

## mutation routes to SerializableCollection's own methods (not Composition)
set_children(coll, list(Clip("z")))
expect_equal(length(children(coll)), 1L)
expect_equal(name(children(coll)[[1]]), "z")
insert_child(coll, 1, Clip("w"))                # 1-based: prepend
expect_equal(name(children(coll)[[1]]), "w")
set_child(coll, 2, Clip("q"))
expect_equal(name(children(coll)[[2]]), "q")
remove_child(coll, 1)
expect_equal(length(children(coll)), 1L)
expect_equal(name(children(coll)[[1]]), "q")
clear_children(coll)
expect_equal(length(children(coll)), 0L)
