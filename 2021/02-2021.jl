# day 02 ---------------------------------------------
using DelimitedFiles

data = readdlm(joinpath(pwd(), "inputs", "input_02.txt"))
instructions = String.(data[:,1])
values = Int.(data[:,2])


# 02a ------------------------------------------------
function sol2a(instructions, values)
   hpos  = 0
   depth = 0

   for (inst, val) in zip(instructions, values)
      inst == "forward" ? hpos  += val :
      inst == "up"      ? depth -= val : depth += val
   end

   return hpos * depth 
end

sol2a(instructions, values)


# 02b ------------------------------------------------
function sol2b(instructions, values)
   hpos  = 0
   depth = 0
   aim   = 0

   for (inst, val) in zip(instructions, values)
      inst == "forward" ? (hpos  += val; 
                           depth += aim * val) :
      inst == "up"      ?  aim   -= val        : aim += val
   end

   return hpos * depth
end

sol2b(instructions, values)
