# Goals And Non-Goals

This document is informational.

## Goals

INC aims to make common tabular data files more self-describing without asking
users to adopt a complex metadata framework.

The goals are:

- keep files readable in ordinary text editors;
- keep the CSV component ordinary and familiar;
- embed essential metadata so it travels with the data;
- support a small shallow metadata structure;
- allow lightweight schema checks for required or forbidden metadata;
- make implementations straightforward in multiple languages;
- remain useful for plain CSV workflows.

## Non-Goals

INC is not:

- a general-purpose metadata standard;
- a full schema language;
- a deeply nested document format;
- a replacement for CSV libraries;
- a metadata catalogue;
- a semantic-web or ontology framework;
- a binary data format;
- a complete archival packaging system.

## Design Biases

INC prefers:

- explicit (simple) rules over clever inference;
- a small allowlist over exposing every parser option;
- readable text over compactness;
- compatibility with CSV tools over richer embedded structure;
- preserving common workflows over maximal expressiveness.
