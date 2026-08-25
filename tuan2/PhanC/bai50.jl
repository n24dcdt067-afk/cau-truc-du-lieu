using Random
using Printf

function do_thoi_gian(n::Int, d::Int, q::Int, seed_val::Int = 42)
    Random.seed!(seed_val)
    D = [rand(d) for _ in 1:n]
    Q = [rand(d) for _ in 1:q]

    # Warm-up JIT
    if n == 1000
        sum((Q[1] .- D[1]) .^ 2)
    end

    t = @elapsed begin
        for u in Q
            min_d = Inf
            best_id = -1
            for j in 1:n
                v = D[j]
                cur_d = sum((u .- v) .^ 2)
                if cur_d < min_d
                    min_d = cur_d
                    best_id = j
                end
            end
        end
    end
    return t
end

function main()
    d = 20
    q = 1000
    N_list = [1000, 10000, 100000]

    println("Ket qua do Julia:")
    println("n\tThoi gian (s)\tTi le T(10n)/T(n)")

    prev_t = 0.0
    for (i, n) in enumerate(N_list)
        t = do_thoi_gian(n, d, q)
        ratio_str = i > 1 ? @sprintf("%.2f", t / prev_t) : "-"
        @printf("%d\t%.4f s\t%s\n", n, t, ratio_str)
        prev_t = t
    end
end

main()