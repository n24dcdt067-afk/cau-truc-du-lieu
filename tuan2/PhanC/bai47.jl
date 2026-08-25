using Printf

struct Mau
    id::Int
    x::Vector{Float64}
    nhan::String
end

function khoang_cach(u::Vector{Float64}, v::Vector{Float64})
    return sqrt(sum((u .- v) .^ 2))
end

function main()
    if !isfile("hoa30.txt")
        println(stderr, "Khong the mo tep hoa30.txt")
        return
    end

    lines = filter(!isempty, strip.(readlines("hoa30.txt")))
    first_line = split(lines[1])
    n = parse(Int, first_line[1])
    d = parse(Int, first_line[2])

    D = Vector{Mau}(undef, n)
    for i in 1:n
        parts = split(lines[i + 1])
        x = [parse(Float64, parts[j]) for j in 1:d]
        nhan = String(parts[d + 1])
        D[i] = Mau(i, x, nhan)
    end

    input_tokens = split(join(readlines(), " "))
    if isempty(input_tokens)
        return
    end

    idx = 1
    while idx <= length(input_tokens)
        u = [parse(Float64, input_tokens[idx + j - 1]) for j in 1:d]
        idx += d

        kc_min = Inf
        du_doan = ""
        id_gan_nhat = -1

        for m in D
            dist = khoang_cach(u, m.x)
            if dist < kc_min
                kc_min = dist
                du_doan = m.nhan
                id_gan_nhat = m.id
            end
        end

        @printf("%s — mau %d, khoang cach %.4f\n", du_doan, id_gan_nhat, kc_min)
    end
end

main()