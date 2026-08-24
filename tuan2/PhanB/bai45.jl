function power_mod(a::Int128, b::Int128, m::Int128)
    if m == 1 return 0 end
    res = Int128(1) % m
    a %= m
    while b > 0
        if b % 2 == 1
            res = (res * a) % m
        end
        a = (a * a) % m
        b = div(b, 2)
    end
    return Int64(res)
end

function main()
    tokens = split(join(readlines(), " "))
    if isempty(tokens) return end
    a, b, m = parse(Int128, tokens[1]), parse(Int128, tokens[2]), parse(Int128, tokens[3])
    println(power_mod(a, b, m))
end
main()