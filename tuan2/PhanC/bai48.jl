using Printf

struct Mau
    id::Int
    x::Vector{Float64}
    nhan::String
end

kc_euclid(u::Vector{Float64}, v::Vector{Float64}) = sqrt(sum((u .- v) .^ 2))
kc_manhattan(u::Vector{Float64}, v::Vector{Float64}) = sum(abs.(u .- v))

function phan_loai(u::Vector{Float64}, D::Vector{Mau}, kc_func::Function; skip_id::Int = -1)
    kc_min = Inf
    du_doan = ""
    id_gan_nhat = -1

    for m in D
        if m.id == skip_id continue end
        dist = kc_func(u, m.x)
        if dist < kc_min
            kc_min = dist
            du_doan = m.nhan
            id_gan_nhat = m.id
        end
    end
    return du_doan, id_gan_nhat
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

    # 1. Phan loai mau (6.5, 3.0, 5.5, 2.0)
    u = [6.5, 3.0, 5.5, 2.0]
    e_nhan, e_id = phan_loai(u, D, kc_euclid)
    m_nhan, m_id = phan_loai(u, D, kc_manhattan)
    println("Mau (6.5, 3.0, 5.5, 2.0):")
    println("Euclid   : $e_nhan (mau $e_id)")
    println("Manhattan: $m_nhan (mau $m_id)\n")

    # 2. Danh gia bo mot mau
    dung_e = 0
    dung_m = 0
    for m in D
        pe_nhan, _ = phan_loai(m.x, D, kc_euclid, skip_id = m.id)
        if pe_nhan == m.nhan dung_e += 1 end

        pm_nhan, pm_id = phan_loai(m.x, D, kc_manhattan, skip_id = m.id)
        if pm_nhan == m.nhan
            dung_m += 1
        else
            println("Manhattan du doan sai mau $(m.id) ($(m.nhan) -> $pm_nhan, gan mau $pm_id)")
        end
    end

    @printf("Do chinh xac Euclid   : %d/%d = %.2f%%\n", dung_e, n, dung_e / n * 100)
    @printf("Do chinh xac Manhattan: %d/%d = %.2f%%\n", dung_m, n, dung_m / n * 100)
end

main()