#!/bin/env julia

import Pkg
Pkg.activate(;temp=true)
Pkg.add("PackageCompiler")
using PackageCompiler

Pkg.activate(".")

create_sysimage(["CairoMakie", "Dagger"]; sysimage_path="sysimage.so", precompile_execution_file="precompile.jl")
