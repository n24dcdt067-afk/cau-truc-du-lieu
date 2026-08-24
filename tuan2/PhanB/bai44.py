import time
import random

def selection_sort(arr):
    a = list(arr)
    n = len(a)
    for i in range(n - 1):
        min_idx = i
        for j in range(i + 1, n):
            if a[j] < a[min_idx]:
                min_idx = j
        a[i], a[min_idx] = a[min_idx], a[i]
    return a

def main():
    sizes = [500, 1000, 2000, 4000]
    times = []
    
    # Khởi động bộ nhớ (warm-up)
    selection_sort([random.randint(1, 100) for _ in range(50)])
    
    for n in sizes:
        min_t = float('inf')
        for _ in range(3):
            data = [random.randint(1, 100000) for _ in range(n)]
            t0 = time.perf_counter()
            selection_sort(data)
            t1 = time.perf_counter()
            min_t = min(min_t, t1 - t0)
        times.append(min_t)
        
    print(f"{'n':<8}{'Thoi gian (s)':<18}{'Ti le T(2n)/T(n)'}")
    print("-" * 40)
    for i in range(len(sizes)):
        ratio = f"{times[i] / times[i-1]:.2f}" if i > 0 else "-"
        print(f"{sizes[i]:<8}{times[i]:<18.6f}{ratio}")

if __name__ == '__main__':
    main()