function knapsack_branch_and_bound()
    names = ['A', 'B', 'C', 'D', 'E', 'F'][cite: 2]
    w = [4, 7, 3, 3, 3, 10][cite: 2]
    v = [19, 25, 7, 8, 9, 21][cite: 2]
    W = 14[cite: 2]
    n = length(names)

    # Sap xep do vat theo ti le v/w giam dan
    items = sort(1:n, by = i -> v[i] / w[i], rev = true)
    names = names[items]
    w = w[items]
    v = v[items]

    function tinh_can(i, current_w, current_v)
        if current_w >= W
            return 0.0
        end
        b = Float64(current_v)
        remain_w = W - current_w
        for j in i:n
            if w[j] <= remain_w
                remain_w -= w[j]
                b += v[j]
            else
                b += v[j] * (remain_w / w[j])
                break
            end
        end
        return b
    end

    # 1. Che do CO cat nhanh
    so_nut_co_cat = 0
    max_v_co_cat = 0
    best_x_co_cat = zeros(Int, n)
    x = zeros(Int, n)

    function thu_co_cat(i, current_w, current_v)
        so_nut_co_cat += 1

        if current_v > max_v_co_cat
            max_v_co_cat = current_v
            best_x_co_cat = copy(x)
        end

        if i > n
            return
        end

        # Nhanh lay do vat i
        if current_w + w[i] <= W
            x[i] = 1
            if tinh_can(i + 1, current_w + w[i], current_v + v[i]) > max_v_co_cat
                thu_co_cat(i + 1, current_w + w[i], current_v + v[i])
            end
            x[i] = 0
        end

        # Nhanh khong lay do vat i
        if tinh_can(i + 1, current_w, current_v) > max_v_co_cat
            x[i] = 0
            thu_co_cat(i + 1, current_w, current_v)
        end
    end

    # 2. Che do KHONG cat nhanh
    so_nut_khong_cat = 0
    max_v_khong_cat = 0

    function thu_khong_cat(i, current_w, current_v)
        so_nut_khong_cat += 1

        if current_v > max_v_khong_cat
            max_v_khong_cat = current_v
        end

        if i > n
            return
        end

        # Nhanh lay do vat i
        if current_w + w[i] <= W
            thu_khong_cat(i + 1, current_w + w[i], current_v + v[i])
        end

        # Nhanh khong lay do vat i
        thu_khong_cat(i + 1, current_w, current_v)
    end

    thu_co_cat(1, 0, 0)
    thu_khong_cat(1, 0, 0)

    println("Thu tu xet sau khi sap xep: ", join(names, ", "))
    println("Gia tri lon nhat: ", max_v_co_cat)
    selected = [names[i] for i in 1:n if best_x_co_cat[i] == 1]
    println("Tap do vat duoc chon: {", join(selected, ", "), "}")
    println("So nut CO cat nhanh: ", so_nut_co_cat)
    println("So nut KHONG cat nhanh: ", so_nut_khong_cat)
    println("So lan giam: ", round(so_nut_khong_cat / so_nut_co_cat, digits=2))
end

knapsack_branch_and_bound()