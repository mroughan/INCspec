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

## How To Build A Test Harness

A conformance harness can be small. It needs four pieces of adapter code for the
implementation being tested:

1. `read_inc(path)`: return metadata and rows for an INC or plain CSV file.
2. `read_schema(path)`: return an implementation-specific schema object.
3. `validate_schema(file, schema)`: return validation status and field lists.
4. `write_inc(path, metadata, columns, rows)`: write an INC file.

The harness then loads the JSON schedules and dispatches by `action`.

Pseudo-code:

```text
manifest = load_json("manifest.json")

for schedule in manifest.schedules:
    tests = load_json(schedule.path).tests
    for test in tests:
        if test.action == "read":
            file = read_inc(resolve(test.fixture))
            compare_metadata(file.metadata, test.expect.metadata)
            compare_csv(file.rows, test.expect.csv)

        if test.action == "read_schema":
            expect_error(lambda: read_schema(resolve(test.fixture)), test.expect_error)

        if test.action == "validate_schema":
            schema = read_schema(resolve(test.schema_fixture))
            file = read_inc(resolve(test.target_fixture))
            report = validate_schema(file, schema)
            compare_validation(report, test.expect)

        if test.action == "write_read_compare":
            path = temporary_file()
            write_inc(path, test.input.metadata, test.input.csv.columns, test.input.csv.rows)
            compare_file(path, resolve(test.expect_canonical_fixture))
            reread = read_inc(path)
            compare_metadata(reread.metadata, metadata_from_input(test.input.metadata))
            compare_csv(reread.rows, test.input.csv)

        if test.action == "read_write_compare":
            file = read_inc(resolve(test.input_fixture))
            path = temporary_file()
            write_inc(path, file.metadata, file.columns, file.rows)
            compare_file(path, resolve(test.expect_canonical_fixture))
```

## Metadata Expectations

Metadata expectations encode scalar values with explicit types:

```json
{
  "title": {"type": "string", "value": "Basic data"},
  "version": {"type": "integer", "value": 1}
}
```

Nested objects represent metadata sections:

```json
{
  "columns": {
    "score": {"type": "string", "value": "points"}
  }
}
```

When comparing metadata:

- require every expected key to be present;
- require no unexpected keys unless a test explicitly allows them;
- compare strings as Unicode strings;
- compare integers as integer values, not strings.

The tests deliberately distinguish quoted integer-looking strings from integer
values. For example, `"007"` is a string, while `7` is an integer.

## CSV Expectations

CSV expectations use a column list and row matrix:

```json
{
  "columns": ["name", "score"],
  "rows": [["Ada", "21"], ["Babbage", "12"]]
}
```

CSV cell comparison should be string-based unless a test says otherwise. This is
important because CSV libraries differ in whether they infer numbers, booleans,
dates, or missing values.

Recommended comparison:

1. Check column names and order.
2. Convert each cell to a string using ordinary display/string conversion.
3. Compare the resulting row matrix to `rows`.

## Error Expectations

Negative tests use abstract error codes:

```json
{
  "expect_error": {"error_code": "invalid_name"}
}
```

Implementations do not need to expose these names directly. The harness can map
implementation-specific errors onto the spec codes.

Current error codes:

| Error code | Meaning |
| --- | --- |
| `missing_closing_delimiter` | Opening metadata delimiter without closing delimiter. |
| `empty_section` | Section has no key/value pairs. |
| `invalid_name` | Key, section, or schema path component violates name rules. |
| `duplicate_key` | Repeated key in the same scope. |
| `unsupported_structure_key` | `[structure]` key is outside the allowlist. |
| `invalid_structure_value` | `[structure]` value has the wrong type or cannot be coerced. |
| `invalid_schema_path` | Schema path is malformed or too deep. |
| `duplicate_schema_requirement` | Schema path appears in more than one requirement class. |

For early implementations, it is acceptable for the harness to treat any thrown
reader error as passing a negative test, then tighten the mapping later.

## Round-Trip Tests

Round-trip tests use canonical fixtures. They are stricter than normal reading
tests because they compare exact file text.

Use them to test writer behavior:

- metadata ordering;
- quoting and escaping;
- delimiter placement;
- CSV header writing;
- read/write stability.

If a host CSV library produces semantically equivalent but textually different
CSV output, the implementation should still pass the read tests. Exact
round-trip canonical tests are strongest for implementations that choose to
match the canonical writer profile.

## Path Resolution

Fixture paths in JSON are relative to the JSON file containing the test.

For example, from `tests/positive.json`:

```json
"fixture": "../fixtures/positive/basic.inc"
```

resolves to:

```text
INCspec/fixtures/positive/basic.inc
```

## Suggested Test Order

For a new implementation, a useful order is:

1. Plain CSV passthrough.
2. Basic INC metadata parsing.
3. Metadata edge cases.
4. `[structure]` delimiter tests.
5. Remaining `[structure]` tests.
6. Negative reader tests.
7. Mini-schema tests.
8. Writer and round-trip tests.

That order lets an implementation become useful early while keeping the stricter
writer and schema behavior as later milestones.
