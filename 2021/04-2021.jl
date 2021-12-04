# day 04 ---------------------------------------------
using DelimitedFiles

input_path = joinpath(@__DIR__, "inputs", "input_04.txt")

draws = parse.(Int, split(readline(input_path), ","))
boards = 
   reshape(
      readdlm(input_path, skipstart = 1, Int) |> permutedims,
      (5, 5, 100)
   )

# functions -----------------------------------------
function marknumber(checkboard, board, number::Int)
   for i = 1:5, j = 1:5
      if checkboard[i,j] ≠ 1
         checkboard[i,j] = board[i,j] == number
      end
   end
   return checkboard
end

function checkbingo(checkboard)
   h_sum = count(checkboard, dims=1)
   v_sum = count(checkboard, dims=2)
   any(x -> x == 5, h_sum) || any(x -> x == 5, v_sum)
end

getscore(checkboard, board, draw) = sum(boards[.!checkboard]) * draw


# 04a ------------------------------------------------
function sol_04a(boards, draws)
   checkboards = falses(size(boards))
   for draw in draws
      for i = 1:size(checkboards, 3)
         checkboards[:,:,i] = marknumber(checkboards[:,:,i], boards[:,:,i], draw)
         checkbingo(checkboards[:,:,i]) && return getscore(checkboards[:,:,i], boards[:,:,i], draw)
      end
   end
end

sol_04a(boards, draws)


# 04b ------------------------------------------------
function sol_04b(boards, draws)

   checkboards = falses(size(boards))
   nboards = size(checkboards, 3)
   bingocheck = falses(nboards)

   for nb in draws
      for i = 1:nboards
         if bingocheck[i] == false
            checkboards[:,:,i] = marknumber(checkboards[:,:,i], boards[:,:,i], nb)
            if checkbingo(checkboards[:,:,i])
               bingocheck[i] = true
               all(bingocheck) && return getscore(checkboards, boards, i, nb)
            end
         end
      end
   end
end


sol_04b(boards, draws)
