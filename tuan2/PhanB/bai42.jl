function main()
    tokens = split(join(readlines(), " "))
    if isempty(tokens) return end
    n, k = parse(Int, tokens[1]), parse(Int, tokens[2])
    if k > n || k <= 0 return end
    a = [parse(Int, tokens[i]) for i in 3:n+2]
    s = sum(a[1:k])
    max_sum = s
    best_start = 1
    for i in (k + 1):n
        s += a[i] - a[i - k]
        if s > max_sum
            max_sum = s
            best_start = i - k + 1
        end
    end
    println("tong $max_sum, bat dau tai vi tri $best_start")
end
main()