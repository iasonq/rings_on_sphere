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
z = @. cos.(θ) * ones(n)'

# Angle for rotation (in radians)

#Select settings for testing purposes
set = 0

if set == 0
    vals0 = ring_ex(x, y, z, "x", 0.01, 0.9, n)
    vals = vals0 .+ rot_ring(vals0, 25, 0, n)
    vals .= vals .+ rot_ring(vals0, 315, 0, n)
    vals_rot = rot_ring(vals0, 0, 25, n)
    vals_rot_2 = rot_ring(vals0, 45, 45, n)
    vals .= vals .+ vals_rot .+ vals_rot_2
    surface(x, y, z, fill_z=vals, size=(600, 600))
elseif set == 1
    vals = ring_ex(x, y, z, "z", 0.01, 0.0, n)
    for i in 1:50
        temp_r = ring_ex(x, y, z, "x", 0.01, 0.95, n)
        temp_r = rot_ring(temp_r, i, 0, n)
        vals .= vals .+ temp_r
    end
    surface(x, y, z, fill_z=vals, size=(600, 600))
else
    vals = ring(x, y, z, "z", "z", 0, 0.01, 0.0, n)
    for δφ in LinRange(0, pi, 10)[1:5]
        vals .= vals .+ ring_ex(x, y, z, "z", "x", "y", pi/5, δφ, 0.01, 0.95, n)#
    end
    surface(x, y, z, fill_z=vals, size=(600, 600))
end

#Create 2 Rings and do a convolution
#ring1 = ring(x, y, z, n, 0, "z")
#ring2 = ring(x, y, z, n, 0, "z")
#vals = conv_c(ring1, ring2, n)