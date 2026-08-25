import sys
import math

def khoang_cach(u, v):
    tong = sum((u[k] - v[k]) ** 2 for k in range(len(u)))
    return math.sqrt(tong)

def main():
    try:
        with open("hoa30.txt", "r") as f:
            lines = [line.strip() for line in f if line.strip()]
    except FileNotFoundError:
        print("Khong the mo tep hoa30.txt", file=sys.stderr)
        return

    first_line = lines[0].split()
    n = int(first_line[0])
    d = int(first_line[1])

    D = []
    for i in range(1, n + 1):
        parts = lines[i].split()
        features = [float(x) for x in parts[:d]]
        nhan = parts[d]
        D.append((i, features, nhan))

    input_data = sys.stdin.read().split()
    if not input_data:
        return

    idx = 0
    while idx < len(input_data):
        u = [float(x) for x in input_data[idx:idx + d]]
        idx += d

        kc_min = float("inf")
        du_doan = None
        id_gan_nhat = -1

        for mid, x, nhan in D:
            dist = khoang_cach(u, x)
            if dist < kc_min:
                kc_min = dist
                du_doan = nhan
                id_gan_nhat = mid

        print(f"{du_doan} — mau {id_gan_nhat}, khoang cach {kc_min:.4f}")

if __name__ == "__main__":
    main()