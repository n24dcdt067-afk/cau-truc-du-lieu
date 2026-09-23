#!/usr/bin/env sh
set -eu
cd -- "$(dirname -- "$0")"
julia --project=julia -e 'using Pkg; Pkg.instantiate()'
exec julia --project=julia julia/app.jl
