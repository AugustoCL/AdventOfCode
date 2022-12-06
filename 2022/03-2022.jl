# day 03 ------------------------------------------------------------------------------------
data = readlines("2023/inputs/input03.txt")
#data = readlines("2023/inputs/sample03.txt")

const priorities = Dict(vcat('a':'z', 'A':'Z') .=> 1:52)

# part 01 -----------------------------------------------------------------------------------
function getitemshared(string::String)
    idx  = length(string) ÷ 2 
    set1 = string[1:idx]
    set2 = string[idx+1:end]
    get(priorities, only(intersect(set1, set2)), 0)
end

map(getitemshared, data) |> sum     # 8394

# part 02 -----------------------------------------------------------------------------------
map(x -> priorities[only(intersect(x...))], 
    collect(Iterators.partition(data, 3))) |> sum   # 2413
