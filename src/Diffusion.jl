module Diffusion

import MPI
using ImplicitGlobalGrid

@views interior(A) = A[2:end-1,2:end-1]

@views north(A) = A[1:end-2,2:end-1]
@views south(A) = A[3:end,  2:end-1]
@views east(A)  = A[2:end-1,1:end-2]
@views west(A)  = A[2:end-1,3:end]

const results_chan = Channel{Any}(1000)
const termination_event = Base.Event()

get_result() = take!(results_chan)
terminate() = notify(termination_event)

function diffusion(T, timesteps, comm)
    nx, ny = size(T)
    coords = MPI.Cart_coords(comm)
    me, dims = init_global_grid(nx, ny, 1; init_MPI=!MPI.Initialized(), comm=comm, reorder=0)  # Initialize the implicit global grid

    put!(results_chan, (coords, collect(interior(T))))

    for t in 1:timesteps
        interior(T) .-= ((north(T) .+ south(T) .+ east(T) .+ west(T)) ./ 4.0)
        update_halo!(T)

        if t % 2 == 0
            put!(results_chan, (coords, collect(interior(T))))
        end
    end

    @info "Finished diffusion" me
    wait(termination_event)
    @info "Worker terminated" me
end

end # module
