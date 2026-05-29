# Changelog

All notable changes to the INC specification are recorded here.

This project follows the specification version in `SPEC_VERSION`. Until the
format reaches a stable release, entries may describe draft-level changes rather
than strict semantic-versioned releases.

## 0.1.0-draft

Initial draft specification.

### Added

- Normative INC file model with optional metadata block and CSV component.
- Metadata syntax rules for names, sections, values, comments, quoting, and
  deterministic writing.
- Explicit metadata line-ending requirements: readers accept LF and CRLF;
  writers should emit LF and avoid mixed metadata line endings.
- `[structure]` section with a small portable CSV parsing allowlist.
- Lightweight mini-schema for required, forbidden, and optional metadata paths.
- Conformance, error, warning, and versioning guidance.
- Language-neutral fixtures and JSON test schedules.
- Informational implementation guide and CSV option mapping notes.
- Known implementation list for Julia, Python, and JavaScript libraries.
