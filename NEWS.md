# RcppOTIO 0.1.0

* First minor release.
* Relicensed from MIT to Apache License 2.0 to match upstream
  OpenTimelineIO.
* CRAN pre-submission polish: single-quote 'Rcpp' and 'OpenTimelineIO' in
  DESCRIPTION, add the OTIO project URL, add URL and BugReports fields.
* Test harness now redirects the R user cache/data/config dirs to
  tempfiles so checks leave no files behind.

# RcppOTIO 0.0.0.8

* Renamed the package from rotio to RcppOTIO. The pure-R OpenTimelineIO
  package now owns the rotio name; this Rcpp/C++ binding becomes RcppOTIO.

# rotio 0.0.0.7

* `to_timecode()` `rate` now defaults to the `RationalTime`'s own rate (OTIO's
  no-rate `to_timecode` overload), e.g. `to_timecode(RationalTime(17982, 30000/1001))`
  infers drop-frame and returns `"00:10:00;00"`.

# rotio 0.0.0.6

* Add GitHub Actions CI (r-ci) on Ubuntu and macOS, building
  OpenTimelineIO from source once per runner and caching the install.
* `src/Makevars` now honours an exported `OTIO_HOME` (via `?=`).

# rotio 0.0.0.5

* Add a getting-started vignette (`vignette("rotio")`) built with
  simplermarkdown.

# rotio 0.0.0.4

* Every exported function now has a runnable `\examples` block, executed by
  `R CMD check`.

# rotio 0.0.0.3

* Wrap the `TypeRegistry` schema upgrade/downgrade hooks:
  `register_upgrade_function()` and `register_downgrade_function()` take R
  callbacks over the schema dictionary, `to_json_string()` /
  `to_json_file()` gain a `target_schema_versions` argument to downgrade on
  write, and `type_version_map()` reports registered schema versions.
* Preserve `const char*` metadata values in the `AnyDictionary` -> R
  conversion instead of dropping them.

# rotio 0.0.0.2

* `Clip` now exposes the full `media_references` map: `media_references()`
  returns the keyed references as a named list and `set_media_references()`
  replaces the map and sets the active key, validating keys and the active
  key.
