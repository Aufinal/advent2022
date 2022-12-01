function findnlargest(lines, n)
    curr = 0
    largest = zeros(Int, n)

    for line in lines
        if isempty(line)
            (min, idx) = findmin(largest)
            if curr > min
                largest[idx] = curr
            end

            curr = 0
        else
            curr += parse(Int, line)
        end
    end

    return largest
end

open(ARGS[1]) do file
    lines = readlines(file)
    largest = findnlargest(lines, 3)

    println("Part one : ", maximum(largest))
    println("Part two : ", sum(largest))
end