# day07 ------------------------------------------------
example = [16,1,2,0,4,2,7,1,2,14]
raw_data = readline(joinpath(@__DIR__, "inputs", "input_07.txt"))
data = parse.(Int, split(raw_data, ","))

# 07a ------------------------------------------------
function sol_07a(data)
    ss = Int[]
    for y in 0:length(data)
        s = 0
        for nb in data
            nb > y ? (s += nb - y) : (s += y - nb)
        end
        push!(ss, s)
    end
    return minimum(ss)
end
sol_07a(example)
sol_07a(data)

# 07b ------------------------------------------------
function sol_07b(data)
    ss = Int[]
    for y in 0:maximum(data)
        s = 0
        for nb in data
            nb > y  ? (s += cumsum(1:(nb - y))[end]) :
            y  > nb ? (s += cumsum(1:(y - nb))[end]) : continue
        end
        push!(ss, s)
    end
    return minimum(ss)
end
sol_07b(example)
sol_07b(data)
