# day 01 ---------------------------------------------
input_path = joinpath(@__DIR__, "inputs", "input_01.txt")
x = parse.(Int, readlines(input_path))

# 01a ------------------------------------------------
sum(x[i] > x[i-1] for i in 2:lastindex(x))
# or
sum(diff(x) .> 0)

# 01b ------------------------------------------------
sum(4:lastindex(x)) do i                                                                                  
   sum(x[(i-3):(i-1)]) < sum(x[i-2:i])                                                                   
end

# alternative solution
# sum([b, c, d]) > sum([a, b, c])
# d + sum([b, c]) > a + sum([b, c])
# d > a
sum(4:lastindex(x)) do i 
   x[i] > x[(i-3)]
end
