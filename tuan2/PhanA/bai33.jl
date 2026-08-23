function main()
    s = strip(read(stdin, String))
    isempty(s) && return
    n = parse(Int, s)

    count = 0
    sum_val = 0

    while n > 0
        sum_val += n % 10
        count += 1
        n = div(n, 10)
    end

    println("$count $sum_val")
end

main()