# pt-Br
# Esse programa vai resolver pêndulo simples 
# utilizando métodos numéricos para EDOs
# os comentários daqui pra frente estarão em 
# inglês

# en-US 
# This program solves the simple pendulum 
# using numerical methods for ODEs

using Plots 
using DifferentialEquations

# defining the function such that the dynamical
# quantitie u(t) would depend 
# i.e. u' = f(u,t,p)

# for the simple pendulum, 
# we need a system of 2 differential 
# equations to account for acceleration
# and velocity as a funcition of position
# or in this case, angular displacement θ

# defining physical constants

g = 9.81 # m/s^2

function f!(du::Array{Float64},u::Array{Float64},p,t::Float64)::Float64
    du[1] = u[2]
    du[2] = -g*sin(u[1])
end


# using the intial conditions of small displacement 
# from rest 

# rest θ = 10 degrees ω = 0 rad/s
u0 = [ 0.1 , 0. ]  

# time span 

tspan = (0.0,10.0)

# defining the ODE in DifferentialEquations method 

prob = ODEProblem(f!,u0,tspan)

sol = solve(prob)

plot(sol,fmt = :png)
savefig("Simple_pendulum/sp_θω.png")