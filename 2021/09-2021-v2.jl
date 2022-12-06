inputpath = 
# Data
lines = readlines(joinpath(@__DIR__, "inputs", "input_09.txt"))
data = Matrix{Int}(undef, length(lines), length(lines[1]))
for i in axes(data, 1)
    data[i, :] .= parse.(Int, split(lines[i], ""))
end

## Part 1 ---------------------------------------------------------------------
