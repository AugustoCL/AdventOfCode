raw_data = readlines("2022/inputs/input01.txt")
#raw_data = readlines("inputs/sample01.txt")

elf_calories = Int[]
calories_sum = 0
for line in raw_data
    if isempty(line) 
        push!(elf_calories, calories_sum)
        calories_sum = 0
    else
        calories_sum += parse(Int, line)
    end
end

# part 01
maximum(elf_calories)

# part 02
sum(sort(elf_calories, rev=true)[1:3])
