#using CairoMakie
using Plots
using DynamicalSystems

# Position of the magnets

m1 = [cos(π/6),sin(π/6)]
m2 = [cos(π/6+2*π/3),sin(π/6+2*π/3)]
m3 = [cos(π/2),sin(-π/2)]

# Absolute value of a vector 
function absv(x)
    s = 0.0
    for i in x
        s += i^2
    end
    return sqrt(s)
end

function sum_dists(r)
    s = [0.,0.]
    for i in [m1,m2,m3]
        s += (i-r)/(absv(i-r)^3)
    end
    return s
end

function f(r,p,t)::SVector

    R = p[1]
    G = p[2]
    K = p[3]
    rx = r[2]
    ry = r[4]
    #rxx,ryy= -R*[rx,ry] - sum_dists([r[1],r[3]]) - G*[abs(r[1]),abs(r[3])]
    rxx,ryy= - G*[r[1],r[3]]-R*[rx,ry]+ K*sum_dists([r[1],r[3]])

    return SVector(rx,rxx,ry,ryy)
end

ds = ContinuousDynamicalSystem(f,[1.,0.,1.,0.],[0.05,0.45,0.05])

#tr = trajectory(ds, 10.0,u = [1.,1.,1.,0.] ,Δt = 0.1)
#tr = trajectory(ds, 20.0,[rand(1)[1],0.,rand(1)[1],0.])
tr = trajectory(ds, 50.0,[1.,0.,1.3,0.])
tr1 = trajectory(ds, 50.0,[1.,0.,1.2,0.])
tr2 = trajectory(ds, 50.0,[1.,0.,1.1,0.])


# defining the figure
begin 
    plot(xlims=(-2,2),ylim=(-2,2),size = (600,600),axis=nothing
    , legend=false,foreground_color_subplot=colorant"white")
    plot!(tr[:,1],tr[:,3],lw=2,color=2)
    plot!(tr1[:,1],tr1[:,3],lw=2,color=3)
    plot!(tr2[:,1],tr2[:,3],lw=2,color=1)
    scatter!([m1[1]],[m1[2]],ms=10,color =1)
    scatter!([m2[1]],[m2[2]],ms=10,color =2)
    scatter!([m3[1]],[m3[2]],ms=10,color =3)
end

begin 

    plot(xlims=(-2,2),ylim=(-2,2),size = (600,600),axis=nothing
    , legend=false,foreground_color_subplot=colorant"white")

    anim = @animate for i in 1:25:length(tr[:,1])
        plot!(tr[:,1],tr[:,3],lw=2,color=2)
    plot!(tr1[:,1],tr1[:,3],lw=2,color=3)
    plot!(tr2[:,1],tr2[:,3],lw=2,color=1)
    scatter!([m1[1]],[m1[2]],ms=10,color =1)
    scatter!([m2[1]],[m2[2]],ms=10,color =2)
    scatter!([m3[1]],[m3[2]],ms=10,color =3)
    end

    gif(anim,"anim_mag_pend2.gif",fps=30)

end

5001/240