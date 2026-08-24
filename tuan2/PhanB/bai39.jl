function cach2(a)
    n = length(a)
    best = a[1]
    for i in 1:n
        s = 0
        for j in i:n
            s += a[j]
            if s > best
                best = s
            end
        end
    end
    return best
end

function main()
    lines = readlines()
    if isempty(lines) return end
    tokens = split(join(lines, " "))
    n = parse(Int, tokens[1])
    a = [parse(Int, tokens[i]) for i in 2:n+1]
    println(cach2(a))
end

main()