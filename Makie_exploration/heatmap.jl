using CairoMakie

function mandelbrot(x, y)
    z = c = x + y*im
    for i in 1:100.0; abs(z) > 2 && return i; z = z^2 + c; end; 0
end

#fig = Figure(resolution = (800, 600))

fog = heatmap(-2:0.002:1, -1.1:0.002:1.1, mandelbrot,
    colormap = Reverse(:deep),resolution = (3200, 2400))

save("mandelbrot.png",fog, pt_per_unit = 1)