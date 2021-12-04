# day 03 ---------------------------------------------
# transform vector of string in matrix of bits
vecofvec = map(readlines(joinpath(@__DIR__, "inputs", "input_03.txt"))) do line
    parse.(Bool, split(line, ""))
end
data = permutedims(hcat(vecofvec...))


# 03a ------------------------------------------------
function sol_03a(data)
      
   # get the most repeated bit, for each collumn, as a binary string 
   gamma_rate   = "0b"
   epsilon_rate = "0b"
   for col in eachcol(data)
      if mean(col) ≥ 0.5
         gamma_rate   *= "1"
         epsilon_rate *= "0"
      else
         gamma_rate   *= "0"
         epsilon_rate *= "1"
      end
   end
   
   # convert binary string to Int
   gamma_rate   = parse(Int, gamma_rate)
   epsilon_rate = parse(Int, epsilon_rate)

   return gamma_rate * epsilon_rate
end

sol_03a(data)


# 03b ------------------------------------------------

function filtermatrix(data, idx; reverse=false)
   if mean(idx) ≥ 0.5 
      if reverse
         return data[(.!idx), :]
      else
         return data[idx, :]
      end
   else
      if reverse
         return data[idx, :]
      else
         return data[(.!idx), :]
      end
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

   # get the most repeated bit, for each collumn, as a binary string 
   bin = "0b"
   for i in dt
      i == true ? (bin *= "1") : (bin *= "0")
   end

   # convert binary string to Int
   return parse(Int, bin)
end

function sol_03b(data)
   oxygen_rate = getdiagnostic(data, order=:mostcommon)
   co2_rate    = getdiagnostic(data, order=:leastcommon)
   return oxygen_rate * co2_rate
end

sol_03b(data)
