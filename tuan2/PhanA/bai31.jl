using Printf

function main()
    tokens = split(read(stdin, String))
    if isempty(tokens)
        return
    end

    n = parse(Int, tokens[1])
    first_val = parse(Int, tokens[2])

    sum_val = first_val
    min_val = first_val
    max_val = first_val

    for i in 2:(n + 1)
        x = parse(Int, tokens[i])
        sum_val += x
        if x < min_val
            min_val = x
        end
        if x > max_val
            max_val = x
        end
    end

    avg = sum_val / n
    @printf("%d %.4f %d %d\n", sum_val, avg, min_val, max_val)
end

main()