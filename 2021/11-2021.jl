# input -------------------------------------------------------------
rawdata = readlines(joinpath(@__DIR__, "inputs", "input_11.txt"))
exampleraw = "5483143223274585471152645561736141336146635738547841675246452176841721688288113448468485545283751526"

data = Matrix{Int}(undef, 10, 10)
exampledata = copy(data)

for (i, line) in enumerate(rawdata)
    data[i,:] .= parse.(Int, split(line, ""))
end
for i = 0:9
    exampledata[i+1,:] = parse.(Int, split(exampleraw[(10*i+1):(10*i+10)], ""))
end


# functions ---------------------------------------------------------
const CI = CartesianIndex
const adj = setdiff(CI(-1,-1):CI(1,1), [CI(0,0)])

step!(data, idx::CI) = data[idx] == 9 ? data[idx] = 0 : data[idx] += 1

function step!(data, idxs::CartesianIndices)
    for idx in idxs
        step!(data, idx)
    end
    idxzeros = filter(x -> data[x] == 0, idxs)
    for idx in idxzeros
        flash!(data, idxs, idx)
    end
end

function flash!(data, idxs, idx)
    for i in adj .+ [idx]
        if i ∈ idxs && data[i] ≠ 0
            step!(data, i)
            data[i] == 0 && flash!(data, idxs, i)
        end
    end
end

# 11a --------------------------------------------------------------
function sol_11a(init, steps::Int)
    data = copy(init)
    idxs = CartesianIndices(data)
    flashs = 0
    for _ in 1:steps
        step!(data, idxs)
        flashs += count(==(0), data)
    end
    return flashs
end

sol_11a(exampledata, 100)
sol_11a(data, 100)

# 11b --------------------------------------------------------------
function sol_11b(init)
    data = copy(init)
    idxs = CartesianIndices(data)
    stepallzeros = 1
    while true
        step!(data, idxs)
        all(iszero.(data)) && break
        stepallzeros += 1
    end
    return stepallzeros
end

sol_11b(exampledata, 100)
sol_11b(data)