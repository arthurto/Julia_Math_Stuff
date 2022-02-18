# pt-Br
# Esse vai procurar o espaço de fase do 
# pêndulo simples físico  
# utilizando métodos numéricos para EDOs
# os comentários daqui pra frente estarão em 
# inglês

# en-US 
# This program solves the simple pendulum 
# and plots its phase space
# using numerical methods for ODEs

using Plots 
using DifferentialEquations

g = 9.81 # m/s^2

function f!(du::Array{Float64},u::Array{Float64},p,t::Float64)::Float64
    du[1] = u[2]
    du[2] = -g*sin(u[1])
end

tspan = (0.0,5.0)
n = 1001 #number of timepoints
ts = range(0, stop=5, length=n)
function phase_spacec_trajectory(θ,ω)
    u0 = [θ,ω]
    prob = ODEProblem(f!,u0,tspan)
    sol = solve(prob)
    return (sol(ts,idxs=2),sol(ts,idxs=1))
end



plot(phase_spacec_trajectory(0.1,0.),
xlabel = "θ [rad]",
ylabel = "ω [rad/2]",
linecolor = RGB(0,0,0),
xlims = (-2*π,2*π),
ylims = (-3,3),label = "")

f = x -> phase_spacec_trajectory(x,0.)

plot!(f.(range(0,stop=10,length = 101)),
linecolor = RGB(0,0,0),
label = "")

savefig("Simple_pendulum/phase_space.png")
