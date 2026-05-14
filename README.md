# INC Specification

This repository contains the language-neutral specification for INC files:
tabular CSV data with included lightweight metadata.

Specification version: `0.1.0-draft`

INC is intended to cover the common case where a CSV file needs a small amount
of metadata that travels with the data. The format is deliberately constrained:
human-readable metadata, a clear separator, and an ordinary CSV component.

## Repository Layout

- `spec/`: normative specification documents.
- `fixtures/positive/`: valid INC and plain CSV examples.
- `fixtures/negative/`: invalid examples that conforming readers should reject.
- `fixtures/roundtrip/`: canonical write/read/write examples.
- `tests/`: machine-readable test schedules.
- `conventions/`: recommended conventions that are not required for conformance.
- `informational/`: explanatory, non-normative supporting documents.
- `scripts/`: optional helper scripts for future validation tooling.

## Normative Documents

- [File Format](spec/file-format.md)
- [Metadata Syntax](spec/metadata-syntax.md)
- [Structure Section](spec/structure.md)
- [Mini Schema](spec/mini-schema.md)
- [Conformance](spec/conformance.md)
- [Errors and Warnings](spec/errors-and-warnings.md)
- [Versioning](spec/versioning.md)
- [Specification Repository Structure](spec/repository-structure.md)

Normative requirements use the RFC 2119 words `MUST`, `MUST_NOT`, `SHOULD`,
`SHOULD_NOT`, and `MAY`.

## Test Manifests

The machine-readable test schedule is stored as JSON:

- `tests/manifest.json`: index of all conformance tests.
- `tests/positive.json`: valid read tests.
- `tests/negative.json`: invalid read tests.
- `tests/roundtrip.json`: read/write/read or write/read/write tests.

The JSON schedules are language neutral. Implementations should map the
expected metadata and rows into native data structures while preserving the
specified values and types.

## Implementations

This specification is intended to be consistent with the Julia and Python INC
implementations. The specification is not tied to any implementation version;
it has its own version number.

Known implementation repositories:

- Julia: [`IncCSV.jl`](https://github.com/mroughan/IncCSV.jl)
- Python: [`IncCSV.py`](https://github.com/lewismath/IncCSV.py)

## Status

This is an initial draft specification. It captures the current format contract
used by the Julia implementation and the desired interoperability target for
other languages.

## Disclosure

This package was developed with assistance from OpenAI Codex, an AI coding
assistant based on GPT-5. Code design decisions were human mediated, and the
resulting code was manually reviewed.
