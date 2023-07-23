using LinearAlgebra
using Plots; plotlyjs()
using DSP;

include("frot.jl")
include("fring.jl")

n = 360
θ = LinRange(0, π, n)
ϕ = LinRange(0, 2π, n)

#coordinate system to create the sphere
#its 2x2 arrays
#@. means elemnt wise 
# the prime : ' means transpose 
#sin(θ)' is the same as sin(θ')
x = @. sin(θ) * cos.(ϕ')
y = @. sin(θ) * sin.(ϕ')
z = @. cos.(θ)* ones(n)'

# Angle for rotation (in radians)

#Select settings for testing purposes
set = 1
#r stands for ration. If i have n= 3600 
#a 25 degree rotation is equivalent to 250 indexes being translated
r = Int(n/360)
#ill start giving r as input as to not write it next to every angle
if set == 0
    vals0 = ring_ex(x, y, z, "z", 0.01, 0.0, n)
    vals1 = ring_ex(x, y, z, "x", 0.01, 0.9, n)
    vals2 = rot_ring(vals0, 90, 0, n)
    vals3 = rot_ring(vals0, 0, 90, n)
    vals = vals0 .+ vals1 .+ vals2 .+ vals3
    surface(x, y, z, fill_z=vals, size=(600, 600))
elseif set == 1
    vals = ring_ex(x, y, z, "z", 0.01, 0.0, n)
    for i in 1:359
        temp_r = ring_ex(x, y, z, "x", 0.01, 0.95, n)
        temp_r = rot_ring(temp_r, i, 0, n)
        vals .= vals .+ temp_r
    end
    surface(x, y, z, fill_z=vals, size=(600, 600))
end

#Create 2 Rings and do a convolution
#ring1 = ring(x, y, z, n, 0, "z")
#ring2 = ring(x, y, z, n, 0, "z")
#vals = conv_c(ring1, ring2, n)