# day 03 ---------------------------------------------
data = readlines(joinpath(@__DIR__, "inputs", "input_03.txt"))

function stringtobitmatrix(data)

   nlin = length(data)
   ncol = length(data[1])

   bit_matrix = BitArray(undef, nlin, ncol)
   for i in 1:nlin
      for j in 1:ncol
         bit_matrix[i,j] = parse(Bool, data[i][j])
      end
   end

   return bit_matrix
end

# 03a ------------------------------------------------
function sol_03a(data)
   
   # transform vector of string in matrix of bits
   bit_matrix = stringtobitmatrix(data)
   
   # get the most repeated bit, for each collumn, as a binary string 
   gamma_rate   = "0b"
   epsilon_rate = "0b"
   for col in eachcol(bit_matrix)
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

function filtermatrix(bit_matrix, idx; reverse=false)
   if mean(idx) ≥ 0.5 
      if reverse
         return bit_matrix[(.!idx), :]
      else
         return bit_matrix[idx, :]
      end
   else
      if reverse
         return bit_matrix[idx, :]
      else
         return bit_matrix[(.!idx), :]
      end
   end
end

function getdiagnostic(data; order=:mostcommon)

   order == :mostcommon  ? (rev = false) :
   order == :leastcommon ? (rev = true)  :
   throw(ArgumentError("wrong argument. Use :mostcommon or :leastcommon"))

   # transform vector of string in matrix of bits
   bit_matrix = stringtobitmatrix(data)

   # # apply the rule
   idx = bit_matrix[:, 1]
   dt = filtermatrix(bit_matrix, idx, reverse=rev)
   for j in 2:size(bit_matrix, 2)
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
