# day10 ---------------------------------------------------------
using SparseArrays

rawdata = readlines(joinpath(@__DIR__, "inputs", "input_13.txt")) 
cmds    = [(Symbol(a), parse(Int, b) + 1) for (a, b) in split.(last.(split.(rawdata[end-11:end], " ")), "=")]
points  = [parse.(Int, (y, x)) .+ 1       for (x, y) in split.(rawdata[begin:(end-13)], ",")]
paper   = sparse(first.(points), last.(points), 1)

# functions -----------------------------------------------------
function fold(paper, cmd::Tuple{Symbol, Int})
    axis, value = cmd
    if axis == :y
        paper = paper[1:value-1, :] + paper[end:-1:value+1, :]
    else
        paper = paper[:, 1:value-1] + paper[:, end:-1:value+1]
    end
    return paper
end

function fold(paper, cmds::Vector{Tuple{Symbol, Int}})
    for cmd in cmds
        paper = fold(paper, cmd)
    end
    return paper
end

# solution --------------------------------------------------------------
sol13a = count(>(0), fold(paper, cmds[1]))
sol13b = fold(paper, cmds)