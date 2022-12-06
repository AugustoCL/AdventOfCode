using StatsBase

# template, _, rawrulers...  = readlines(joinpath(@__DIR__, "inputs", "input_14_demo.txt"))
template, _, rawrulers...  = readlines(joinpath(@__DIR__, "inputs", "input_14.txt"))
const rulers = Dict(=>(x...) for x in split.(rawrulers, " -> "))


function validrules(template, rulers) 
    rulesoccured = [filter(r -> occursin(r, template), keys(rulers))...]
    rgs = [findall(x, template, overlap=true) for x in rulesoccured]
    sizeofranges = size.(rgs, 1)
    
    fullrules = vcat([fill(rulesoccured[i], sz) for (i,sz) in enumerate(sizeofranges)]...)
    fullrgs = vcat(rgs...)
    
    return fullrules[sortperm(fullrgs)], fullrgs[sortperm(fullrgs)]
end

function updatestr(template, rulers)
    strmatchs, rgs = validrules(template, rulers)
    rgs = extrema.(rgs)
    newtemplate = template
    n = 0
    for (str, b, e) in zip(strmatchs, first.(rgs), last.(rgs))
        newtemplate = newtemplate[begin:b+n] * rulers[str] * newtemplate[e+n:end]
        # println(rpad("$b-$e", 5), " || ", template[begin:b-1], " ", template[b:e], " ", template[e+1:end], " -> ", newtemplate[begin:b+n], " ", rulers[str], " ", newtemplate[e+n:end])
        n += 1
    end
    return newtemplate
end

function sol14(template, rulers, nsteps)
    newtemplate = template
    for _ in 1:nsteps
        newtemplate = updatestr(newtemplate, rulers)
    end
    countdict = countmap([char for char in newtemplate])
    a, b = extrema(values(countdict))
    return b - a
end

println("Part 1: ", sol14(template, rulers, 10))
# second part with 40 steps doesn't fit in memory
# sol14(template, rulers, 40)


# draft code to test if it was working
updatestr(template, rulers)
                          #   NCNBCHB
updatestr(updatestr(template, rulers), rulers)
                                             #   NBCCNBBBCBHCB
updatestr(updatestr(updatestr(template, rulers), rulers), rulers)
                                                                #   NBBBCNCCNBBNBNBBCHBHHBCHB
                                                                    NBBBCNCCNBBNBNBBCHBHHBCHB


