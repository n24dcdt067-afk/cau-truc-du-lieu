import sys
import math

# 9 mẫu huấn luyện từ Ví dụ 1.8 giáo trình
D = [
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

def main():
    data = sys.stdin.read().split()
    if not data:
        return
    u1, u2 = float(data[0]), float(data[1])

    kc_min = float('inf')
    du_doan = None
    id_gan_nhat = -1

    for mid, x1, x2, nhan in D:
        d = math.sqrt((u1 - x1)**2 + (u2 - x2)**2)
        if d < kc_min:
            kc_min = d
            du_doan = nhan
            id_gan_nhat = mid

    print(f"{du_doan} — lang gieng la mau {id_gan_nhat}, khoang cach {kc_min:.4f}")

if __name__ == '__main__':
    main()