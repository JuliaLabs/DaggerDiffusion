# Dagger & MPI 

## Local setup
```julia
import Pkg
Pkg.instantiate()

import MPI
MPI.install_mpiexecjl(;destdir=".")
```

## Running it locally
```
./mpiexecjl --project -np 9 julia --project main.jl
```