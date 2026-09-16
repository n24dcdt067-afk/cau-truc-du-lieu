def doi_tien_tham_lam(menh_gia, S):
    coins = sorted(menh_gia, reverse=True)
    cach_tra = []
    tong = S
    for c in coins:
        while tong >= c:
            cach_tra.append(c)
            tong -= c
    return len(cach_tra), cach_tra


def doi_tien_qhd(menh_gia, S):
    dp = [float("inf")] * (S + 1)
    vet = [-1] * (S + 1)
    dp[0] = 0

    for i in range(1, S + 1):
        for c in menh_gia:
            if i >= c and dp[i - c] + 1 < dp[i]:
                dp[i] = dp[i - c] + 1
                vet[i] = c

    cach_tra = []
    curr = S
    while curr > 0:
        c = vet[curr]
        cach_tra.append(c)
        curr -= c

    return dp[S], cach_tra


if __name__ == "__main__":
    bo_du_lieu = [
        ([1, 4, 6, 9], 12),
        ([1, 5, 10, 20, 50], 85),
        ([1, 3, 7, 12], 20),
        ([1, 2, 5, 10], 38),
        ([1, 6, 10], 12),
        ([1, 4, 5, 15, 20], 23),
    ]

    for idx, (menh_gia, S) in enumerate(bo_du_lieu, 1):
        so_to_tl, cach_tl = doi_tien_tham_lam(menh_gia, S)
        so_to_dp, cach_dp = doi_tien_qhd(menh_gia, S)
        dung = "Có" if so_to_tl == so_to_dp else "Không"

        str_tl = " + ".join(map(str, cach_tl))
        str_dp = " + ".join(map(str, cach_dp))

        print(f"Bộ {idx}:")
        print(f"  Tham lam ({so_to_tl} tờ): {str_tl}")
        print(f"  Tối ưu   ({so_to_dp} tờ): {str_dp}")
        print(f"  Tham lam đúng? {dung}\n")