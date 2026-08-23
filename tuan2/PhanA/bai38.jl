# Julia (bai38.jl)
function main()
    tokens = split(read(stdin, String))
    if isempty(tokens) return end

    n = parse(Int, tokens[1])
    a = [parse(Int, tokens[i]) for i in 2:(n + 1)]

    strict_inc = true
    non_dec = true

    for i in 1:(n - 1)
        if a[i] >= a[i + 1]
            strict_inc = false
        end
        if a[i] > a[i + 1]
            non_dec = false
        end
        if !strict_inc && !non_dec
            break
        end
    end

    res1 = strict_inc ? "YES" : "NO"
    res2 = non_dec ? "YES" : "NO"
    println("$res1 — $res2")
end

main()