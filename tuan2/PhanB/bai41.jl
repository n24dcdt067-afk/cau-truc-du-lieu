function main()
    tokens = split(join(readlines(), " "))
    if isempty(tokens) return end
    n = parse(Int, tokens[1])
    a = [parse(Int, tokens[i]) for i in 2:n+1]
    best = max_prod = min_prod = a[1]
    for i in 2:n
        x = a[i]
        if x < 0 max_prod, min_prod = min_prod, max_prod end
        max_prod = max(x, max_prod * x)
        min_prod = min(x, min_prod * x)
        best = max(best, max_prod)
    end
    println(best)
end
main()