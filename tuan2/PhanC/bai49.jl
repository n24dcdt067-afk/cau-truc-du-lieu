using Printf

struct Mau
    id::Int
    x::Vector{Float64}
    nhan::String
end

kc_euclid(u::Vector{Float64}, v::Vector{Float64}) = sqrt(sum((u .- v) .^ 2))
kc_manhattan(u::Vector{Float64}, v::Vector{Float64}) = sum(abs.(u .- v))

function danh_gia_loocv(D::Vector{Mau}, ten_do_do::String, kc_func::Function)
    n = length(D)
    dung = 0
    ds_sai = String[]

    for i in 1:n
        kc_min = Inf
        du_doan = ""

        for j in 1:n
            if i == j continue end # Bỏ qua chính mẫu đang xét
            dist = kc_func(D[i].x, D[j].x)
            if dist < kc_min
                kc_min = dist
                du_doan = D[j].nhan
            end
        end

        if du_doan == D[i].nhan
            dung += 1
        else
            push!(ds_sai, "Mau $(D[i].id) (that: $(D[i].nhan), du doan: $du_doan)")
        end
    end

    ti_le = dung / n * 100.0
    @printf("%s: %d/%d = %.2f%%\n", ten_do_do, dung, n, ti_le)
    if isempty(ds_sai)
        println("  -> Khong co mau nao bi sai.")
    else
        println("  -> Cac mau bi sai:")
        for s in ds_sai
            println("     $s")
        end
    end
end

function main()
    if !isfile("hoa30.txt")
        println(stderr, "Khong the mo tep hoa30.txt")
        return
    end

    lines = filter(!isempty, strip.(readlines("hoa30.txt")))
    n, d = parse.(Int, split(lines[1]))

    D = Vector{Mau}(undef, n)
    for i in 1:n
        parts = split(lines[i + 1])
        x = parse.(Float64, parts[1:d])
        nhan = String(parts[d + 1])
        D[i] = Mau(i, x, nhan)
    end

    println("=== KET QUA DANH GIA LOOCV TREN HOA30.TXT ===")
    danh_gia_loocv(D, "Euclid", kc_euclid)
    danh_gia_loocv(D, "Manhattan", kc_manhattan)
end

main()