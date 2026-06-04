# The one place where OTIO's 0-based indexing meets R's 1-based indexing.
#
# OTIO addresses composition children and image-sequence images by 0-based
# integer. The R surface is 1-based throughout, so every index/number that
# crosses the boundary goes through these two helpers and nowhere else.
# Keep all such translation here; do not sprinkle `- 1L` / `+ 1L` across
# the wrappers.

# R 1-based position -> OTIO 0-based index (for passing into C++).
.to_otio_index <- function(i) as.integer(i) - 1L

# OTIO 0-based index -> R 1-based position (for values coming out of C++).
# Negative inputs (OTIO's "not found") become NA.
.from_otio_index <- function(i) if (i < 0L) NA_integer_ else i + 1L
