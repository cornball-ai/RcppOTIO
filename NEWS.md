# rotio 0.0.0.2

* `Clip` now exposes the full `media_references` map: `media_references()`
  returns the keyed references as a named list and `set_media_references()`
  replaces the map and sets the active key, validating keys and the active
  key.
