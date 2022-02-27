using CairoMakie

function mandelbrot(x, y)
    z = c = x + y*im
    for i in 1:200.0; abs(z) > 2 && return i; z = z^2 + c; end; 0
end

fog = heatmap(-2:0.001:1, -1.1:0.001:1.1, mandelbrot,
    colormap = Reverse(:deep),resolution = (3200, 2400))

save("Makie_exploration/mandelbrot.png",fog, pt_per_unit = 100)