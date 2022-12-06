
# template, _, rawrulers...  = readlines(joinpath(@__DIR__, "inputs", "input_14_demo.txt"))
template, _, rulersraw...  = readlines(joinpath(@__DIR__, "inputs", "input_14.txt"))
const rulers = Dict(=>(x...) for x in split.(rulersraw, " -> "))


function countchars(template, rulers, steps)
    cntpairs = Dict(p => count(p, template, overlap=true) for p in keys(rulers))
    cntchars = Dict(string(c) => count(c, template) for c in unique(template))
    for _ in 1:steps
        temp = filter(p -> last(p) > 0, cntpairs)
        for p in keys(temp)
            cntpairs[p] -= temp[p]
            cntpairs[p[1]*rulers[p]] += temp[p]
            cntpairs[rulers[p]*p[2]] += temp[p]
            cntchars[rulers[p]] += temp[p]
        end
    end
    return cntchars
end

## Part 1 -----------------------------------------------------------------------
# Solution: 2194
counts = values(countchars(template, rulers, 10))
maximum(counts) - minimum(counts)

## Part 2 -----------------------------------------------------------------------
# Solution: 2360298895777
counts = values(countchars(template, rulers, 40))
maximum(counts) - minimum(counts)
