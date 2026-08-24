function main()
    tokens = split(join(readlines(), " "))
    if isempty(tokens) return end
    n = parse(Int, tokens[1])
    a = [parse(Int, tokens[i]) for i in 2:n+1]
    best = cur = a[1]
    start_idx = end_idx = temp_start = 1
    for i in 2:n
        if cur < 0 cur, temp_start = a[i], i
        else cur += a[i] end
        if cur > best best, start_idx, end_idx = cur, temp_start, i end
    end
    println("tong $best, doan [$start_idx..$end_idx]")
end
main()