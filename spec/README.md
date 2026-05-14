# Specification Guide

This directory contains the normative INC specification documents.

If you are reading the specification for the first time, start here:

1. [File Format](file-format.md): the top-level shape of an INC file.
2. [Metadata Syntax](metadata-syntax.md): the metadata grammar, quoting,
   escaping, comments, names, sections, and values.
3. [Structure Section](structure.md): the allowed `[structure]` CSV parser hints.
4. [Mini Schema](mini-schema.md): the lightweight metadata schema format.
5. [Conformance](conformance.md): what readers, writers, and schema validators
   must do.
6. [Errors And Warnings](errors-and-warnings.md): required rejection cases and
   recommended diagnostics.
7. [Versioning](versioning.md): how specification versions are named.

The repository layout itself is described in
[Specification Repository Structure](repository-structure.md).

## Normative Language

These documents use RFC 2119-style requirement words:

- `MUST`
- `MUST_NOT`
- `SHOULD`
- `SHOULD_NOT`
- `MAY`

Statements using these words are normative. Plain explanatory prose is still
part of the specification, but the requirement words identify the strongest
conformance obligations.

## Scope

The specification defines:

- the INC file shape;
- metadata syntax and value types;
- delimiter rules;
- the `[structure]` allowlist;
- mini-schema syntax and validation behavior;
- required reader and writer errors;
- conformance expectations.

The specification does not define:

- every detail of CSV parsing;
- a full metadata ontology;
- a full type system beyond `integer` and `string` metadata values;
- a general configuration language;
- host-language API names.

## Relationship To Tests

The documents in this directory define the rules. The files in `../fixtures/`
and `../tests/` provide executable examples of those rules.

When implementing INC in a new language, read these specification documents
first, then use the JSON schedules in `../tests/` to build a conformance test
harness.

## Informational Material

Non-normative background and guidance lives outside this directory:

- `../informational/`: goals, implementation guide, and CSV option comparisons.
- `../conventions/`: recommended but non-required conventions.

Those documents are useful for understanding design intent, but they do not add
new conformance requirements unless a normative document explicitly says so.
