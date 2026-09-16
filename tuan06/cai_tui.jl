# Quy uoc chi so: Julia danh chi so mang tu 1.
# Bang f co 6 hang (i chay tu 0 den n) va 12 cot (j chay tu 0 den W).
# Do do, trang thai f[i][j] cua bai toan duoc luu tai f[i + 1, j + 1].

function cai_tui()
    n = 5
    W = 11
    ten = ["A", "B", "C", "D", "E"]
    w = [2, 3, 4, 5, 7]
    v = [3, 7, 9, 12, 16]

    f = zeros(Int, n + 1, W + 1)

    for i in 1:n
        for j in 0:W
            f[i + 1, j + 1] = f[i, j + 1]
            if w[i] <= j
                f[i + 1, j + 1] = max(f[i + 1, j + 1], f[i, j - w[i] + 1] + v[i])
            end
        end
    end

    println("Bang f (kich thuoc 6 x 12):")
    for i in 0:n
        for j in 0:W
            print(lpad(f[i + 1, j + 1], 4))
        end
        println()
    end

    chon = String[]
    j = W
    for i in n:-1:1
        if f[i + 1, j + 1] != f[i, j + 1]
            push!(chon, ten[i])
            j -= w[i]
        end
    end
    reverse!(chon)

    println("Gia tri lon nhat f[5][11]: ", f[n + 1, W + 1])
    println("Tap do vat duoc chon: ", join(chon, ", "))
end

cai_tui()