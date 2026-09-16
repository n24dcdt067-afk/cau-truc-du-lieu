# Julia đánh chỉ số mảng từ 1.
# Với bài toán đổi tiền S, mảng dp và mảng truy vết có kích thước S + 1
# tương ứng với số tiền từ 0 đến S: giá trị tại số tiền `v` nằm ở chỉ số `v + 1`.

function doi_tien_tham_lam(menh_gia, S)
    coins = sort(menh_gia, rev=true)
    cach_tra = Int[]
    tong = S
    for c in coins
        while tong >= c
            push!(cach_tra, c)
            tong -= c
        end
    end
    return length(cach_tra), cach_tra
end

function doi_tien_qhd(menh_gia, S)
    INF = 10^9
    dp = fill(INF, S + 1)
    vet = fill(-1, S + 1)
    dp[0 + 1] = 0

    for i in 1:S
        for c in menh_gia
            if i >= c && dp[i - c + 1] + 1 < dp[i + 1]
                dp[i + 1] = dp[i - c + 1] + 1
                vet[i + 1] = c
            end
        end
    end

    cach_tra = Int[]
    curr = S
    while curr > 0
        c = vet[curr + 1]
        push!(cach_tra, c)
        curr -= c
    end

    return dp[S + 1], cach_tra
end

function main()
    ds_bo = [
        ([1, 4, 6, 9], 12),
        ([1, 5, 10, 20, 50], 85),
        ([1, 3, 7, 12], 20),
        ([1, 2, 5, 10], 38),
        ([1, 6, 10], 12),
        ([1, 4, 5, 15, 20], 23)
    ]

    for (idx, (menh_gia, S)) in enumerate(ds_bo)
        so_to_tl, cach_tl = doi_tien_tham_lam(menh_gia, S)
        so_to_dp, cach_dp = doi_tien_qhd(menh_gia, S)
        dung = (so_to_tl == so_to_dp) ? "Có" : "Không"

        println("Bộ ", idx, ":")
        println("  Tham lam (", so_to_tl, " tờ): ", join(cach_tl, " + "))
        println("  Tối ưu   (", so_to_dp, " tờ): ", join(cach_dp, " + "))
        println("  Tham lam đúng? ", dung, "\n")
    end
end

main()