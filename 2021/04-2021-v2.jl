# day 04 ---------------------------------------------
using DelimitedFiles

input_path = joinpath(@__DIR__, "inputs", "input_04.txt")

draws = parse.(Int, split(readline(input_path), ","))

raw_boards = readdlm(input_path, skipstart = 1, Int)
boards = [raw_boards[i:i+4, :] for i = 1:5:500]


# useful functions -----------------------------------
function marknumber(checkboard, board, number::Int)
   for i = 1:5, j = 1:5
      if checkboard[i,j] ≠ 1
         checkboard[i,j] = board[i,j] == number
      end
   end
   return checkboard
end

function checkbingo(checkboard, i)
   horiz_sum = count(checkboard[i], dims=1)
   verti_sum = count(checkboard[i], dims=2)
   any(x -> x == 5, horiz_sum) || any(x -> x == 5, verti_sum)
end

function getscore(checkboards, boards, i, nb)
   unmarked_bits = .!checkboards[i]
   unmarked_values = boards[i][unmarked_bits]
   sum(unmarked_values) * nb
end


# 04a ------------------------------------------------
function sol_04a(checkboards, boards, draws)
   nums = Set{Int}()
   for draw in draws
      push!(nums, draw)
      for (i, board) in enumerate(boards)
         checkboards[i] = marknumber(checkboards[i], board, draw)
         checkbingo(checkboards, i) && return getscore(checkboards, boards, i, draw)
      end
   end
end

checkboards = [falses(5, 5) for _ in 1:100]
sol_04a(checkboards, boards, draws)


# 04b ------------------------------------------------
function sol_04b(checkboards, boards, draws)
   
   nboards = size(checkboards, 1)
   boardsbingo = falses(nboards)

   for draw in draws
      for (i, board) in enumerate(boards)
         if boardsbingo[i] == false
            checkboards[i] = marknumber(checkboards[i], board, draw)
            if checkbingo(checkboards, i)
               boardsbingo[i] = true
               all(boardsbingo) && return getscore(checkboards, boards, i, draw)
            end
         end
      end
   end

end

checkboards = [falses(5, 5) for _ in 1:100]
sol_04b(checkboards, boards, draws)
