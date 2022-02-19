using PackageCompiler
import Pkg

Pkg.activate(".")

create_sysimage(["CairoMakie", "Dagger"]; sysimage_path="sysimage.so")
