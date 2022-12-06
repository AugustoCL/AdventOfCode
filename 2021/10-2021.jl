# day10 ---------------------------------------------------------
data = readlines(joinpath(@__DIR__, "inputs", "input_10.txt"))

# functions -----------------------------------------------------
const RULES  = Dict('(' => ')', '[' => ']', '{' => '}', '<' => '>')
const POINTS = Dict(')' => 1,   ']' => 2,   '}' => 3,   '>' => 4)

function iscorrupted(string)
    stack = Char[]
    for char in string
        haskey(RULES, char)       ? push!(stack, char) :
        char == RULES[stack[end]] ? pop!(stack)        : (return true, char, nothing)
    end
    return false, nothing, stack
end

function score(itr)
    s = 0
    for i in itr
        s *= 5
        s += POINTS[i]
    end
    return s
end

# solution --------------------------------------------------------------
function sol_10a(data)
    wrongchars = Char[]
    for line in data
        corrupted, firsterror, _ = iscorrupted(line)
        corrupted && push!(wrongchars, firsterror)
    end
    points = Dict(')' => 3, ']' => 57, '}' => 1197, '>' => 25137)
    return sum([points[i] for i in wrongchars])
end

function sol_10b(data)
    allincompletes = []
    for line in data
        corrupted, _, stack = iscorrupted(line)
        !corrupted && push!(allincompletes, [RULES[i] for i in reverse(stack)])
    end
    return median([score(line) for line in allincompletes])
end

sol_10a(data)
sol_10b(data)
using Printf 
@printf "%10.0f" sol_10b(data)