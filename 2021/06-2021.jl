# day 06 ---------------------------------------------

# 06 ------------------------------------------------
function sol_06a(data, N)
   for i in 1:N
      if 0 ∈ data
         n = count(==(0), data)
         replace!(data, 0 => 7)
         push!(data, fill(9, n)...)
      end
      data .-= 1
   end
   return length(data)
end

example = "3,4,3,1,2"
data_example = parse.(Int, split(example, ","))
sol_06a(data_example, 150)
sol_06a(data_example, 18)

input_path = joinpath(@__DIR__, "inputs", "input_06.txt")
data = parse.(Int, split(readline(input_path), ","))
sol_06a(data, 80)

# 06 elias solution ------------------------------------

function sol(data, days)
   sim = Dict(i => count(==(i), data) for i in 0:8)
   idx = vcat(0:5,7)

   for _ in 1:days
      old = copy(sim)
      for i in idx
         sim[i] = old[i+1]
      end
      sim[6] = old[7] + old[0]
      sim[8] = old[0]
   end

   return sum(values(sim))
end
sol(data_example, 80)