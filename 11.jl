mutable struct Monkey{T<:Function}
    items::Vector{Int}
    operation::T
    test_div::Int
    if_true::Int
    if_false::Int
    n_inspected::Int
end

function inspect!(monkey, monkeys, modulo)
    monkey.n_inspected += length(monkey.items)
    for item in monkey.items
        worry = Base.invokelatest(monkey.operation, item) % modulo
        to_monkey = iszero(worry % monkey.test_div) ? monkey.if_true : monkey.if_false
        push!(monkeys[to_monkey + 1].items, worry)
    end
    empty!(monkey.items)
end

function parse_monkey(str)
    lines = strip.(split(str, "\n"))
    starting_items = parse.(Int, split(chopprefix(lines[2], "Starting items: "), ", "))
    operation = eval(Meta.parse("(old) -> " * last(split(lines[3], " = "))))
    test_div = parse(Int, last(split(lines[4])))
    if_true = parse(Int, last(split(lines[5])))
    if_false = parse(Int, last(split(lines[6])))
    
    return Monkey(starting_items, operation, test_div, if_true, if_false, 0)
end

open(ARGS[1]) do file
    monkeys = parse_monkey.(split(read(file, String), "\n\n"))
    modulo = prod(monkey -> monkey.test_div, monkeys)
    for i in 1:10000
        foreach(monkey -> inspect!(monkey, monkeys, modulo), monkeys)
    end
    n_inspected = map(monkey -> monkey.n_inspected, monkeys)
    println(prod(partialsort(n_inspected, 1:2, rev=true)))
end
