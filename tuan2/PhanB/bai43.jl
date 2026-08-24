function fib_lap(n::Int)
    if n <= 2
        return Int64(1)
    end
    a, b = Int64(1), Int64(1)
    for _ in 3:n
        a, b = b, a + b
    end
    return b
end

function main()
    line = readline()
    if isempty(strip(line))
        return
    end
    n = parse(Int, strip(line))
    if n > 92
        println("tran long long")
    else
        println("F = $(fib_lap(n))")
    end
end

main()