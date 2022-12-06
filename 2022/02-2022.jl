# day 02 ------------------------------------------------------------------------------------
using DelimitedFiles

# read data
data = readdlm("2022/inputs/input02.txt")
enemy = data[:, 1]
hero  = data[:, 2]

# auxiliar functions
get_shape_score(X, score) = get.(Ref(score), X, 0)
get_outcome_score(h, e, score) = score[h][e]


# part 01 -----------------------------------------------------------------------------------
const shape_score = Dict("X" => 1, "Y" => 2, "Z" => 3)

const outcome_score = Dict(
    "X" => Dict("A" => 3, "B" => 0, "C" => 6),
    "Y" => Dict("A" => 6, "B" => 3, "C" => 0),
    "Z" => Dict("A" => 0, "B" => 6, "C" => 3)  
)

result_shape_hero = get_shape_score(hero, shape_score)
result_outcome = get_outcome_score.(hero, enemy, Ref(outcome_score))

sum(result_shape_hero + result_outcome) # 14069


# part 02 -----------------------------------------------------------------------------------
const outcome_score2 = Dict("X" => 0, "Y" => 3, "Z" => 6)

const shape_score2 = Dict(
    "X" => Dict("A" => 3, "B" => 1, "C" => 2),
    "Y" => Dict("A" => 1, "B" => 2, "C" => 3),
    "Z" => Dict("A" => 2, "B" => 3, "C" => 1)  
)

result_shape_hero2 = get_shape_score(hero, outcome_score2)
result_outcome2 = get_outcome_score.(hero, enemy, Ref(shape_score2))

sum(result_shape_hero2 + result_outcome2) # 12411