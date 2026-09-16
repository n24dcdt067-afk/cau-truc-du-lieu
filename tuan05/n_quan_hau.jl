function solve_n_queens()
    print("Nhap n: ")
    n = parse(Int, readline())

    so_nut = 0
    so_loi_giai = 0
    loi_giai_dau = Int[]

    x = zeros(Int, n)
    cot = falses(n)
    cheo1 = falses(2 * n)
    cheo2 = falses(2 * n)

    function dat_hau(i)
        so_nut += 1

        if i > n
            so_loi_giai += 1
            if so_loi_giai == 1
                loi_giai_dau = copy(x)
            end
            return
        end

        for j in 1:n
            if !cot[j] && !cheo1[i + j] && !cheo2[i - j + n]
                x[i] = j
                cot[j] = cheo1[i + j] = cheo2[i - j + n] = true

                dat_hau(i + 1)

                cot[j] = cheo1[i + j] = cheo2[i - j + n] = false
            end
        end
    end

    dat_hau(1)

    println("So nut da duyet: ", so_nut)
    println("So loi giai: ", so_loi_giai)
    println("Ban co cua loi giai dau tien:")

    if so_loi_giai > 0
        for r in 1:n
            for c in 1:n
                if loi_giai_dau[r] == c
                    print("Q ")
                else
                    print(". ")
                end
            end
            println()
        end
    else
        println("Khong co loi giai hop le.")
    end
end

solve_n_queens()