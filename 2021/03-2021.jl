# day 03 ---------------------------------------------
vecofvec = map(readlines(joinpath(@__DIR__, "inputs", "input_03.txt"))) do line
    parse.(Bool, split(line, ""))
end
data = permutedims(hcat(vecofvec...))

# 03a ------------------------------------------------
function sol_03a(data)
   # length of the bits
   n = size(data, 1)

   # get the most repeated bit, for each collumn, as a binary string 
   gamma_bit   = sum(data, dims=1) .≥ n/2
   epsilon_bit = .!gamma_bit
   gamma_str   = "0b" * join(string.(Int.(gamma_bit)))
   epsilon_str = "0b" * join(string.(Int.(epsilon_bit)))

   # convert binary string to int
   gamma_rate   = parse(Int, gamma_str)
   epsilon_rate = parse(Int, epsilon_str)

   return gamma_rate * epsilon_rate
end

sol_03a(data)

# 03b ------------------------------------------------
function filtermatrix(data, idx; reverse=false)
   if mean(idx) ≥ 0.5 
      reverse ? (return data[(.!idx), :]) : (return data[idx, :])
   else
      reverse ? (return data[idx, :])     : (return data[(.!idx), :])
   end
end

function getdiagnostic(data; order=:mostcommon)

   order == :mostcommon  ? (rev = false) :
   order == :leastcommon ? (rev = true)  :
   throw(ArgumentError("wrong argument. Use :mostcommon or :leastcommon"))

   # apply the rule
   idx = data[:, 1]
   dt = filtermatrix(data, idx, reverse=rev)
   for j in 2:size(data, 2)
      idx = dt[:, j]
      dt = filtermatrix(dt, idx, reverse=rev)
      size(dt, 1) == 1 && break
   end

   # BitVector -> Vector Int -> Binary String 
   bin = "0b" * join(string.(Int.(dt)))
   
   # Binary String -> Int
   return parse(Int, bin)
end

function sol_03b(data)
   O₂_rate  = getdiagnostic(data, order=:mostcommon)
   CO₂_rate = getdiagnostic(data, order=:leastcommon)
   return O₂_rate * CO₂_rate
end

sol_03b(data)
