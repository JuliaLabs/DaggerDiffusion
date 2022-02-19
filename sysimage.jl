using PackageCompiler
import Pkg

Pkg.activate(".")

create_sysimage(["CairoMakie"]; sysimage_path="sysimage.so", precompile_execution_file="precompile.jl")
