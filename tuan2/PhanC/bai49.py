import sys
import math

def kc_euclid(u, v):
    return math.sqrt(sum((u[k] - v[k]) ** 2 for k in range(len(u))))

def kc_manhattan(u, v):
    return sum(abs(u[k] - v[k]) for k in range(len(u)))

def danh_gia_loocv(D, ten_do_do, kc_func):
    n = len(D)
    dung = 0
    ds_sai = []

    for i in range(n):
        kc_min = float("inf")
        du_doan = None

        for j in range(n):
            if i == j:
                continue # Bỏ qua chính mẫu đang xét
            dist = kc_func(D[i][1], D[j][1])
            if dist < kc_min:
                kc_min = dist
                du_doan = D[j][2]

        if du_doan == D[i][2]:
            dung += 1
        else:
            ds_sai.append(f"Mau {D[i][0]} (that: {D[i][2]}, du doan: {du_doan})")

    ti_le = dung / n * 100.0
    print(f"{ten_do_do}: {dung}/{n} = {ti_le:.2f}%")
    if not ds_sai:
        print("  -> Khong co mau nao bi sai.")
    else:
        print("  -> Cac mau bi sai:")
        for s in ds_sai:
            print(f"     {s}")

def main():
    try:
        with open("hoa30.txt", "r") as f:
            lines = [line.strip() for line in f if line.strip()]
    except FileNotFoundError:
        print("Khong the mo tep hoa30.txt", file=sys.stderr)
        return

    n, d = map(int, lines[0].split())
    D = []
    for i in range(1, n + 1):
        parts = lines[i].split()
        features = [float(x) for x in parts[:d]]
        nhan = parts[d]
        D.append((i, features, nhan))

    print("=== KET QUA DANH GIA LOOCV TREN HOA30.TXT ===")
    danh_gia_loocv(D, "Euclid", kc_euclid)
    danh_gia_loocv(D, "Manhattan", kc_manhattan)

if __name__ == "__main__":
    main()