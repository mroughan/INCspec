# CSV Options Rosetta Stone

This document is informational.

It compares common CSV parser options in Julia, Python, and R, and notes whether
each option belongs in INC `[structure]`.

The INC `[structure]` allowlist is intentionally small:

- `delim`
- `delimiter`
- `quotechar`
- `escapechar`
- `comment`
- `header`
- `footerskip`

Other parser controls should be supplied as language-specific reader arguments.

## Packages

| Language | Suggested package |
| --- | --- |
| Julia | `CSV.jl` |
| Python | standard-library `csv` for minimal use; `pandas` optional for DataFrame workflows |
| R | base `utils::read.csv` / `utils::read.table`; `readr` as a tidyverse option |

## Option Mapping

| Concept | INC `[structure]` | Julia CSV.jl | Python `csv` | R base | R readr |
| --- | --- | --- | --- | --- | --- |
| Field delimiter | `delim` or `delimiter` | `delim` | `delimiter` | `sep` | `delim` |
| Quote character | `quotechar` | `quotechar` | `quotechar` | `quote` | `quote` |
| Escape character | `escapechar` | `escapechar` | `escapechar` | limited / context dependent | `escape_backslash`, `escape_double` |
| Comment marker | `comment` | `comment` | no built-in `DictReader` option; pre-filter lines | `comment.char` | `comment` |
| Header row | `header` | `header` | fieldnames or first row behavior | `header` plus `skip` | `col_names` plus `skip` |
| Footer rows | `footerskip` | `footerskip` | pre-filter or post-trim lines | no direct base option | no direct simple option |
| Skip initial rows | not in `[structure]` | `skipto` or `skip` behavior | pre-filter lines | `skip` | `skip` |
| Limit rows | not in `[structure]` | `limit` | iterator slicing | `nrows` | `n_max` |
| Missing value marker | not in `[structure]` | `missingstring` | post-processing or custom handling | `na.strings` | `na` |
| Decimal marker | not in `[structure]` | `decimal` | locale/custom parsing | `dec` | `locale(decimal_mark=...)` |
| Grouping marker | not in `[structure]` | `groupmark` | custom parsing | custom parsing | `locale(grouping_mark=...)` |
| Name normalization | not in `[structure]` | `normalizenames` | post-processing | `check.names` | name repair behavior |

## Notes

The table is a guide, not a conformance rule.

INC uses names primarily based on CSV.jl where practical, but does not expose
the full CSV.jl keyword surface in `[structure]`.

For portable INC files, use `[structure]` for the small set of options that
describe the file's basic CSV shape. Use language-specific reader arguments for
analysis choices or advanced parser behavior.
