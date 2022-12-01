open(ARGS[1]) do file
    l = []
    s = 0
    for line in readlines(file)
        if isempty(line)
            append!(l, s)
            s = 0
        else
            s += parse(Int, line)
        end
    end

    print(sum(sort(l)[end-2:end]))
end