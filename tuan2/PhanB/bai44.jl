using Random
using Printf

function selection_sort(a)
    arr = copy(a)
    n = length(arr)
    for i in 1:(n - 1)
        min_idx = i
        for j in (i + 1):n
            if arr[j] < arr[min_idx]
                min_idx = j
            end
        end
        arr[i], arr[min_idx] = arr[min_idx], arr[i]
    end
    return arr
end

function main()
    sizes = [500, 1000, 2000, 4000]
    times = Float64[]
    
    # Chạy khởi động để biên dịch JIT
    selection_sort(rand(1:100, 50))
    
    for n in sizes
        min_t = Inf
        for _ in 1:3
            data = rand(1:100000, n)
            t = @elapsed selection_sort(data)
            min_t = min(min_t, t)
        end
        push!(times, min_t)
    end
    
    println("n\tThoi gian (s)\tTi le T(2n)/T(n)")
    for i in 1:length(sizes)
        ratio = i > 1 ? @sprintf("%.2f", times[i] / times[i-1]) : "-"
        @printf("%d\t%.6f\t%s\n", sizes[i], times[i], ratio)
    end
end

main()