# INC Implementations

This page lists known INC implementations and related tooling.

## Libraries

- Julia: [`IncCSV.jl`](https://github.com/mroughan/IncCSV.jl)
  - Reads and writes INC files using CSV.jl for the CSV component.
  - Includes metadata parsing, `[structure]` support, schema validation, examples,
    and documentation.
- Python: [`IncCSV.py`](https://github.com/lewismath/IncCSV.py)
  - Reads and writes INC files from Python.
  - Provides schema validation, summaries, and optional pandas integration.
- JavaScript: [`IncCSV.js`](../IncCSV.js/)
  - Reads and writes INC text in browsers and Node.js.
  - Provides `[structure]` support, mini-schema validation, and a Node
    conformance test harness.

## Conformance

Implementations should be checked against the language-neutral fixtures and JSON
test schedules in this specification repository:

- [`fixtures/`](fixtures/)
- [`tests/`](tests/)

The specification has its own version number and is not tied to any particular
implementation release.
