#=
x,y,z are the 2-dim arrays, which we also use to create the sphere
axis is the axis around which we rotate
w is the angle at which we rotate
by create the circle around whatever axis we want we should be able to rotate it anywhere we want

del is the Δ, thickness of the ring
pos is at which point on the axis it spawns, 0 is for largest radius 
-1 or 1 is for point at the end of the sphere

General idea: create normal rings with ring() as belts at a certain height
Create rotated rings with ring_ex(). A rotation around z and x is sufficient
=#
function ring(x, y, z, axis, raxis, w, del, pos, n)
    arr = zeros(n, n)
    rotated_x, rotated_y, rotated_z = rotate_coordinates(x, y, z, raxis, w, n)
    #i can make a subroutine in here for additional rotations 
    if axis == "x"
        init = rotated_x
    elseif axis == "y"
        init = rotated_y
    else
        init = rotated_z
    end

    for i in 1:n
        for j in 1:n
            if pos - del <= init[i, j] <= pos + del
                arr[i, j] = 1
            end
        end
    end
    return arr
end

#expanded ring function with 2 rotations
function ring_exr(x, y, z, axis, raxis1, raxis2, w1, w2, del, pos, n)
    arr = zeros(n, n)
    rx, ry, rz = rotate_coordinates( x,  y,  z, raxis1, w1, n)
    rx, ry, rz = rotate_coordinates(rx, ry, rz, raxis2, w2, n)
    if axis == "x"
        init = rx
    elseif axis == "y"
        init = ry
    else
        init = rz
    end

    for i in 1:n
        for j in 1:n
            if pos - del <= init[i, j] <= pos + del
                arr[i, j] = 1
            end
        end
    end
    return arr
end

function ring_ex(x, y, z, axis, del, pos, n)
    arr = zeros(n, n)
    if axis == "x"
        init = x
    elseif axis == "y"
        init = y
    else
        init = z
    end
    for i in 1:n
        for j in 1:n
            if pos - del <= init[i, j] <= pos + del
                arr[i, j] = 1
            end
        end
    end
    return arr
end

#one final attempt to create rings on a sphere is by 
#rotating the conditions for creating the ring
