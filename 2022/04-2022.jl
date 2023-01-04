# day04 -------------------------------------------------------------------------------------
rawdata = readlines("2022/inputs/input04.txt")      # 2022/inputs/sample04.txt

function isoverlap(line; full=false)
    l1, r1, l2, r2 = parse.(Int, split(line, r"-|,"))
    a, b = l1:r1, l2:r2

    if full
        a ⊆ b || b ⊆ a
    else
        !isempty(a ∩ b)
    end
end

# part 01 -----------------------------------------------------------------------------------
isoverlap.(rawdata, full=true) |> sum   # 462

# part 02 -----------------------------------------------------------------------------------
isoverlap.(rawdata) |> sum              # 835
