function main()
    s = strip(read(stdin, String))
    isempty(s) && return
    n = parse(Int, s)

    is_neg = (n < 0)
    n = abs(n)

    rev = 0
    while n > 0
        rev = rev * 10 + (n % 10)
        n = div(n, 10)
    end

    if is_neg
        rev = -rev
    end

    println(rev)
end

main()