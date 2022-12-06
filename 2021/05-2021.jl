# day 05 ---------------------------------------------
function readdata(input_path)
   x1, y1, x2, y2 = Int[], Int[], Int[], Int[]
   for line in readlines(input_path)
      point1, point2 = split(line, " -> ")
      x1s, y1s = parse.(Int, split(point1, ","))
      x2s, y2s = parse.(Int, split(point2, ","))
      push!(x1,x1s)
      push!(x2,x2s)
      push!(y1,y1s)
      push!(y2,y2s)
   end
   return [x1 x2 y1 y2]
end
input_path = joinpath(@__DIR__, "inputs", "input_05.txt")
data = readdata(input_path)

# functions --------------------------------------------
vecofvec = Array{Tuple{Int, Int}}(undef, 0)
for segment in eachrow(data)
   x1, x2, y1, y2 = [segment...]
   x1 < x2 ? (x = x1:1:x2) : (x = x2:-1:x1)
   y1 < y2 ? (y = y1:1:y2) : (y = y2:-1:y1)
   xs = filter(x -> size(x,1) == 1 || size(x,2) == 1, x)
   ys = filter(y -> size(y,1) == 1 || size(y,2) == 1, y)
   rangepoints = Base.product(xs,ys) |> collect
   append!(vecofvec, rangepoints)
end
# allpoints = unique(vecofvec)

# 05a --------------------------------------------
function sol_05a(allpoints)
   checkboard = zeros(Int, 1000, 1000)

   for p in allpoints
      checkboard[p...] += 1
   end

   return count(>(1), checkboard)
end
sol_05a(vecofvec)
