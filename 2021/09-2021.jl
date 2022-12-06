inputpath = joinpath(@__DIR__, "inputs", "input_09.txt")
rawdata = readlines(inputpath)
data = Matrix{Int}(undef, length(rawdata), length(rawdata[1]))
for i in eachindex(rawdata)
    data[i,:] .= parse.(Int, split(rawdata[i], ""))
end

exampleraw = "21999432103987894921985678989287678967899899965678"
exampledata = Matrix{Int}(undef, 5, 10)
for i = 0:4
    exampledata[i+1,:] = parse.(Int, split(exampleraw[(10*i+1):(10*i+10)], ""))
end

function sol09a(data)
    nl, nc = size(data)
    idxs = falses(nl, nc)
    for j in axes(data, 2), i in axes(data, 1)
        islow = trues(4)

        i > 1  ? (data[i-1,j] ≤ data[i,j] && (islow[1] = false)) : nothing
        i < nl ? (data[i+1,j] ≤ data[i,j] && (islow[2] = false)) : nothing
        j > 1  ? (data[i,j-1] ≤ data[i,j] && (islow[3] = false)) : nothing
        j < nc ? (data[i,j+1] ≤ data[i,j] && (islow[4] = false)) : nothing

        all(islow) && (idxs[i,j] = true)
    end
    return sum(data[idxs] .+ 1)
end
sol09a(exampledata)
sol09a(data)

function searchbasin!(idxs, data, i, j)
    basinsize = 0
    nl, nc = size(data)
    idxs[i,j] = true
    
    if (i > 1)  && (data[i-1,j] == data[i,j] + 1) && (idxs[i-1,j] ≠ true) && (data[i-1,j] ≠ 9)
        idxs[i-1,j] = true
        basinsize += searchbasin!(idxs, data, i-1, j) + 1
    end
    
    if (i < nl) && (data[i+1,j] == data[i,j] + 1) && (idxs[i+1,j] ≠ true) && (data[i+1,j] ≠ 9)
        idxs[i+1,j] = true
        basinsize += searchbasin!(idxs, data, i+1, j) + 1
    end
    
    if (j > 1)  && (data[i,j-1] == data[i,j] + 1) && (idxs[i,j-1] ≠ true) && (data[i,j-1] ≠ 9)
        idxs[i,j-1] = true
        basinsize += searchbasin!(idxs, data, i, j-1) + 1
    end
    
    if (j < nc) && (data[i,j+1] == data[i,j] + 1) && (idxs[i,j+1] ≠ true) && (data[i,j+1] ≠ 9)
        idxs[i,j+1] = true
        basinsize += searchbasin!(idxs, data, i, j+1) + 1
    end
    
    return basinsize
end

function sol09b(data)
    nl, nc = size(data)
    idxs = falses(nl, nc)
    sumofbasins = Int[]
    for j in axes(data, 2), i in axes(data, 1)
        islow = trues(4)

        i > 1  ? (data[i-1,j] ≤ data[i,j] && (islow[1] = false)) : nothing
        i < nl ? (data[i+1,j] ≤ data[i,j] && (islow[2] = false)) : nothing
        j > 1  ? (data[i,j-1] ≤ data[i,j] && (islow[3] = false)) : nothing
        j < nc ? (data[i,j+1] ≤ data[i,j] && (islow[4] = false)) : nothing

        if all(islow) 
            idxs[i,j] = true
            nn = searchbasin!(idxs, data, i, j) + 1
            println((i,j), " - ", nn)
            push!(sumofbasins, nn)
        end
    end
    
    return sort(sumofbasins, rev=true)[1:3] |> prod
end

sol09b(exampledata)
sol09b(data)
