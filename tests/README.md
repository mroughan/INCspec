# Test Schedules

The JSON files in this directory describe language-neutral conformance tests.

## Files

- `manifest.json`: index and comparison rules.
- `positive.json`: valid read and validation tests.
- `negative.json`: invalid read and schema-read tests.
- `roundtrip.json`: canonical writer round-trip tests.

## Actions

The following actions are used:

- `read`: read an INC or plain CSV file.
- `read_schema`: read an INC mini-schema file.
- `validate_schema`: read a schema and target file, then validate the target.
- `write_read_compare`: write the specified metadata and CSV data, read it
  again, and compare with the canonical fixture.
- `read_write_compare`: read the input fixture, write it again, and compare with
  the canonical fixture.

## Comparison

Metadata values should be compared by value and declared type.

CSV cell values should be compared after converting implementation-native cell
values to strings, unless a test states otherwise. This avoids making the INC
specification depend on a particular CSV library's type inference behavior.

Error tests compare an abstract `error_code`. Implementations do not need to use
these exact names internally, but test harnesses should map implementation
errors onto these codes.
