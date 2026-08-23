# Julia (bai35.jl)
using Printf

function main()
    s = strip(read(stdin, String))
    isempty(s) && return
    n = parse(Int, s)
    n < 2 && return

    is_prime = fill(true, n + 1)
    is_prime[1] = false # số 0
    is_prime[2] = false # số 1

    p = 2
    while p * p <= n
        if is_prime[p + 1]
            for i in (p * p):p:n
                is_prime[i + 1] = false
            end
        end
        p += 1
    end

    if n <= 30
        res = [i for i in 2:n if is_prime[i + 1]]
        println(join(res, " "))
    else
        count = 0
        total_sum = 0
        for i in 2:n
            if is_prime[i + 1]
                count += 1
                total_sum += i
            end
        end
        @printf("so luong = %d, tong = %d\n", count, total_sum)
    end
end

main()