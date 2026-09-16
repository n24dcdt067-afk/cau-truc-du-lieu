def cai_tui(w, v, W, ten_do_vat):
    n = len(w)
    f = [[0] * (W + 1) for _ in range(n + 1)]

    for i in range(1, n + 1):
        for j in range(W + 1):
            f[i][j] = f[i - 1][j]
            if w[i - 1] <= j:
                f[i][j] = max(f[i][j], f[i - 1][j - w[i - 1]] + v[i - 1])

    chon = []
    j = W
    for i in range(n, 0, -1):
        if f[i][j] != f[i - 1][j]:
            chon.append(ten_do_vat[i - 1])
            j -= w[i - 1]

    chon.reverse()
    return f, f[n][W], chon


if __name__ == "__main__":
    ten = ["A", "B", "C", "D", "E"]
    w = [2, 3, 4, 5, 7]
    v = [3, 7, 9, 12, 16]
    W = 11

    bang_f, gia_tri_max, vat_chon = cai_tui(w, v, W, ten)

    print("Bang f (kich thuoc 6 x 12):")
    for row in bang_f:
        print(" ".join(f"{x:3d}" for x in row))

    print(f"Gia tri lon nhat f[5][11]: {gia_tri_max}")
    print(f"Tap do vat duoc chon: {vat_chon}")