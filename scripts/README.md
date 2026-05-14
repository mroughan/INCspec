# Scripts

This directory is reserved for optional helper scripts.

Future scripts may validate JSON schedules, generate fixture summaries, or run
an implementation-specific conformance adapter.

No script is required for specification conformance.

## Julia Conformance Runner

`run_julia_conformance.jl` checks the shared spec fixtures against a local
`IncCSV.jl` checkout:

```sh
cd INCspec
julia --project=../IncCSV.jl scripts/run_julia_conformance.jl
```

It covers positive reads, negative reads, schema validation, and canonical
round-trip writes.
