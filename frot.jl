function rotation_matrix(raxis, w)
    if raxis == "x"
        R = [1  0   0;
             0  cos(w) -sin(w);
             0  sin(w)  cos(w)]
    elseif raxis == "y"
        R = [cos(w) 0 sin(w);
             0 1 0;
             -sin(w) 0 cos(w)]
    else 
        R = [cos(w) -sin(w) 0;
             sin(w)  cos(w) 0;
             0 0 1]
    end
    return R
end

function rotate_coordinates(x, y, z, raxis, w, n)
    #n = size(x, 1)
    #m = size(x, 2)
    rotated_x = similar(x)
    rotated_y = similar(y)
    rotated_z = similar(z)

    R = rotation_matrix(raxis, w)

    for i in 1:n
        for j in 1:n
            v = R * [x[i, j], y[i, j], z[i, j]]
            rotated_x[i, j] = v[1]
            rotated_y[i, j] = v[2]
            rotated_z[i, j] = v[3]
        end
    end
    return rotated_x, rotated_y, rotated_z
end

#different type of rotation
#each point [x,y,z] correspond to a point on the sphere
#designated by θ, φ basically

#rotations for rings initialized around z axis cannot be performed

function rot_ring(ring, w1, w2, n)
    #For rings created around the x-axis / with their center on the x-axis.
    #First we rotate around the x-axis then around the z-axis. 
    #Assuming n = 360
    #so w1 is in degrees... not radians
    #θ rotation -> around x : ax1 at an angle w1
    #it was working without htis if statement for whatever reason
    #arr = similar(ring)
    if w1 != 0
        ring = vcat(ring[(n - w1):n, :], ring[1:(n-w1-1), :])
    end
    #φ rotation -> around z: ax2 at angle w2
    if w2 != 0 
        ring = hcat(ring[:, (n-w2):n], ring[:, 1:(n-w2-1)]) 
    end
    return ring
end