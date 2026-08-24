using Printf

const D = [
    (1, 1.4, 0.2, "Setosa"),
    (2, 1.3, 0.2, "Setosa"),
    (3, 1.5, 0.2, "Setosa"),
    (4, 4.7, 1.4, "Versicolor"),
    (5, 4.5, 1.5, "Versicolor"),
    (6, 4.9, 1.5, "Versicolor"),
    (7, 6.0, 2.5, "Virginica"),
    (8, 5.8, 2.2, "Virginica"),
    (9, 6.3, 1.8, "Virginica")
]

function main()
    tokens = split(join(readlines(), " "))
    if isempty(tokens) return end
    u1, u2 = parse(Float64, tokens[1]), parse(Float64, tokens[2])

    kc_min = Inf
    du_doan = ""
    id_gan_nhat = -1

    for (mid, x1, x2, nhan) in D
        d = sqrt((u1 - x1)^2 + (u2 - x2)^2)
        if d < kc_min
            kc_min = d
            du_doan = nhan
            id_gan_nhat = mid
        end
    end

    @printf("%s — lang gieng la mau %d, khoang cach %.4f\n", du_doan, id_gan_nhat, kc_min)
end
main()