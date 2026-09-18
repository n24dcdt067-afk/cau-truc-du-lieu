function thu(i::Int, n::Int, x::Vector{Int}, da_dung::Vector{Bool})
    if i > n
        p = 3  # Thay 2 bang p trong R0 (Ca s = 6)
        if x[1] != p
            return 0
        end
        println(join(x, " "))
        return 1
    end

    dem = 0
    for v in 1:n
        if !da_dung[v]
            x[i] = v
            da_dung[v] = true
            dem += thu(i + 1, n, x, da_dung)
            da_dung[v] = false  # Hoan tac
        end
    end
    return dem
end

function main()
    println("MSSV: N24DCDT067 | Ma ca: 6")
    println("Nhap n (1..8):")
    n = tryparse(Int, strip(readline()))
    if n === nothing || !(1 <= n <= 8)
        println("Du lieu khong hop le.")
        return
    end

    x = zeros(Int, n)
    da_dung = fill(false, n)
    dem = thu(1, n, x, da_dung)
    println("So hoan vi dat: ", dem)
end

main()