# Scripts

This directory is reserved for optional helper scripts.

A the moment, there is only one that tests the Julia implementation for conformance (see below).

Future scripts may validate JSON schedules, generate fixture summaries, or run
an implementation-specific conformance adapter.

No script is required for specification conformance, but it would be potentially very helpful to have these so that we can track all of the implementations and test them together.

## Julia Conformance Runner

`run_julia_conformance.jl` checks the shared spec fixtures against a local
`IncCSV.jl` checkout:

```sh
cd INCspec
julia --project=../IncCSV.jl scripts/run_julia_conformance.jl
```

It covers positive reads, negative reads, schema validation, and canonical
round-trip writes. 
