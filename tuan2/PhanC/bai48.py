import sys
import math

def kc_euclid(u, v):
    return math.sqrt(sum((u[k] - v[k]) ** 2 for k in range(len(u))))

def kc_manhattan(u, v):
    return sum(abs(u[k] - v[k]) for k in range(len(u)))

def phan_loai(u, D, kc_func, skip_id=-1):
    kc_min = float("inf")
    du_doan = None
    id_gan_nhat = -1

    for mid, x, nhan in D:
        if mid == skip_id:
            continue
        dist = kc_func(u, x)
        if dist < kc_min:
            kc_min = dist
            du_doan = nhan
            id_gan_nhat = mid
    return du_doan, id_gan_nhat

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

    # 1. Phan loai mau (6.5, 3.0, 5.5, 2.0)
    u = [6.5, 3.0, 5.5, 2.0]
    e_nhan, e_id = phan_loai(u, D, kc_euclid)
    m_nhan, m_id = phan_loai(u, D, kc_manhattan)
    print("Mau (6.5, 3.0, 5.5, 2.0):")
    print(f"Euclid   : {e_nhan} (mau {e_id})")
    print(f"Manhattan: {m_nhan} (mau {m_id})\n")

    # 2. Danh gia bo mot mau
    dung_e = 0
    dung_m = 0
    for mid, x, nhan in D:
        pe_nhan, _ = phan_loai(x, D, kc_euclid, skip_id=mid)
        if pe_nhan == nhan:
            dung_e += 1

        pm_nhan, pm_id = phan_loai(x, D, kc_manhattan, skip_id=mid)
        if pm_nhan == nhan:
            dung_m += 1
        else:
            print(f"Manhattan du doan sai mau {mid} ({nhan} -> {pm_nhan}, gan mau {pm_id})")

    print(f"Do chinh xac Euclid   : {dung_e}/{n} = {dung_e / n * 100:.2f}%")
    print(f"Do chinh xac Manhattan: {dung_m}/{n} = {dung_m / n * 100:.2f}%")

if __name__ == "__main__":
    main()