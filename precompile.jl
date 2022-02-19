using CairoMakie

T    = zeros(62, 62)
node = Observable(T)
fig  = heatmap(node, colorrange = (0.0, 2.0))

record(fig, "output.mkv", 1:1) do t
    node[] = T
end