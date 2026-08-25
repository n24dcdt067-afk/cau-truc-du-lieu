import time
import random

def do_thoi_gian(n, d, q, seed_val=42):
    random.seed(seed_val)
    D = [[random.random() for _ in range(d)] for _ in range(n)]
    Q = [[random.random() for _ in range(d)] for _ in range(q)]

    t0 = time.perf_counter()
    for u in Q:
        min_d = float("inf")
        best_id = -1
        for j in range(n):
            v = D[j]
            cur_d = sum((u[k] - v[k]) ** 2 for k in range(d))
            if cur_d < min_d:
                min_d = cur_d
                best_id = j
    t1 = time.perf_counter()
    return t1 - t0

def main():
    d = 20
    q = 1000
    N_list = [1000, 10000, 100000]

    print("Ket qua do Python:")
    print(f"{'n':<8}{'Thoi gian (s)':<18}{'Ti le T(10n)/T(n)'}")
    print("-" * 40)

    prev_t = 0.0
    for i, n in enumerate(N_list):
        if n == 100000:
            # Do 100 mau va nhan 10 de tiet kiem thoi gian
            t = do_thoi_gian(n, d, 100) * 10
        else:
            t = do_thoi_gian(n, d, q)
        
        ratio = f"{t / prev_t:.2f}" if i > 0 else "-"
        print(f"{n:<8}{t:<18.4f}{ratio}")
        prev_t = t

if __name__ == "__main__":
    main()